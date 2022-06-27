Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5D455D890
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbiF0Qd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbiF0Qdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:33:55 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B35D13D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:33:53 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CF9DB22247;
        Mon, 27 Jun 2022 18:33:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656347632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l+azEMFKfRDci09MlPg1YZmgjW15Gzr9vlc9D1324NU=;
        b=uVLWU94DFQf/a85KG2KjXyEkkwABpcz76IaunWLoGaaNT4Qg5vU/UqVPPnB/KGSHM1DMzW
        Qr6EGT2MXAE5IRmkfXqWtrpPrj4HB/CmyQdYNj9l2rWLLdFYhm+nWE3/2DcX8sEz7tj1PH
        +XP0uZNKa9yGO8GFCaZ1Ljfe2LfbyLk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 27 Jun 2022 18:33:51 +0200
From:   Michael Walle <michael@walle.cc>
To:     Steve French <smfrench@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: nfc: drop Charles Gorand from NXP-NCI
In-Reply-To: <CAH2r5ms_jsG7KpPzYyF3jnW+O3c191fR-nY+GT51hDa6b4tb3g@mail.gmail.com>
References: <CAH2r5ms_jsG7KpPzYyF3jnW+O3c191fR-nY+GT51hDa6b4tb3g@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <81ecf8cfb0e0e0338b60c64251d9e1d3@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-06-26 22:59, schrieb Steve French:
>> Mails to Charles get an auto reply, that he is no longer working at
>> Eff'Innov technologies. Drop the entry and mark the driver as 
>> orphaned.
> 
> The Documentation file for this driver
> (Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml) lists a
> second maintainer:
>       Krzysztof Kozlowski <krzk@kernel.org>
> 
> Should the maintainer entry for this driver in the MAINTAINERS file be
> changed to him?

I'm not sure, Krzysztof is the overall maintainer of the NFC subsystem.
Krzysztof?

In any case, the state should be changed from Supported to either
Maintained or Orphan.

But I guess, Charles non-functional email should also be removed from 
the
device tree binding.

-michael
