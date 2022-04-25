Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2131E50DA62
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241394AbiDYHut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbiDYHuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:50:14 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192DA11C04;
        Mon, 25 Apr 2022 00:47:07 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9F2C260009;
        Mon, 25 Apr 2022 07:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650872826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yol92uYBYu5c5ADYJPECESSMs16zXfz4k/koZ3ocm6Q=;
        b=Yy92DEql1uyL2BDtVEAjk3oki/kgZ5bfq1+ArgerhnCsoEI4LZyM5ZFKh/Ad2IHa2GgB6l
        6OZV0n3axgIyzwnstDvkXR/KKWFEbfq8YHWYk0b6Y+kBxXxuTq78H28itMzc2tyl/+yzI4
        Cxreoe7wAsDSnafjnfAP7t0/AICcnhTdnwqLjG+inw8KDYmSQ9RJj27EWuktLS7s0wHGvd
        66qUZQ27C0dXCxE5vI7quCTz7v1NhdRTTvbAW0Ak4i6+2Z87FOCVLeTtg3N7WmkvKg+oMl
        p7Ylte63OCQ+jK1r6FvXa+lWqZhvYztfe5/K3gLW/X9DwAP+knCzMwrFon7tbg==
Date:   Mon, 25 Apr 2022 09:47:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Drop empty and unreferenced binding .txt
 files
Message-ID: <20220425094702.5cdf4f2b@xps13>
In-Reply-To: <20220422191958.2589318-1-robh@kernel.org>
References: <20220422191958.2589318-1-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Fri, 22 Apr 2022 14:19:57 -0500:

> Drop a couple of old, empty .txt binding files which are no longer
> referenced.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

For the MTD file:

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
