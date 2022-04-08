Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40174F8F35
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiDHHMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiDHHMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:12:25 -0400
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C28113CE7;
        Fri,  8 Apr 2022 00:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649401800; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=MmiAXIAKk19pYhrM4Aik2YO5yTmZ1UPPK6sKjaV1qtG638cf4uDWPIS3M9jo8MkEcBY+LKqoNjbfP9XzV/nza1kdeWvfi4kLgB4DPTxJhHumOIEdIBEeCwRYuaA6INYhFb1v0hvHjo+TowSGzsf70OlU/K/2qbrDPImMc9F+B9Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649401800; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=eg9fa4mgvSov9adJT7QuT/g9DxpZmotsvTIi0D2NY64=; 
        b=Wxv4dadT6rIS6uIqF9YsJFoHEZvwe8Qhmx30iX5MOwgiEBHXizQFINIJwFcnSk0ggKGEMMXyJ4Eue262LFbP/PMTdsZsiUbY0qZNA81gxviolKbTzwlTFKuxKwXcSi7rJY3LaCH7wjeEpUnJAmgbtkNELAPHh28WzRyouov/nUM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649401800;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Content-Type:Content-Transfer-Encoding:From:From:Mime-Version:Subject:Subject:Date:Date:Message-Id:Message-Id:References:Cc:Cc:In-Reply-To:To:To:Reply-To;
        bh=eg9fa4mgvSov9adJT7QuT/g9DxpZmotsvTIi0D2NY64=;
        b=aEvyzih9cImRpRa+B7JZwXqnjhk5sXPYln1IGy9nzpbOLadJNq0GK0B/lx996zsV
        ft/sKqbsEt/n8WR4cVJmHSXUNynpMQcOOpOPxfF52dH9OqJ0kCi132ivBnEHubUumux
        tS1lE8S1XdjQ9bfVqFHj3Z43QWkmODhhIalkVJho=
Received: from [10.10.9.3] (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649401797701217.1237282746249; Fri, 8 Apr 2022 00:09:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] MIPS: dts: align SPI NOR node name with dtschema
Date:   Fri, 8 Apr 2022 10:09:45 +0300
Message-Id: <DD1B5C64-D5F2-4AA7-8420-92E06B51D6B9@arinc9.com>
References: <20220407143328.295762-1-krzysztof.kozlowski@linaro.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20220407143328.295762-1-krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: iPhone Mail (17H35)
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 7 Apr 2022, at 17:33, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.o=
rg> wrote:
>=20
> =EF=BB=BFThe node names should be generic and SPI NOR dtschema expects "fl=
ash".
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

For ralink mt7621:

Acked-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>

Thanks.
Ar=C4=B1n=C3=A7=

