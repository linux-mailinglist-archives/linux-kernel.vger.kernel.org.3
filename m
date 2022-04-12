Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA99B4FDF96
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352644AbiDLMVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355422AbiDLMTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:19:10 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87B05D5C1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:22:09 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5710C5C0269;
        Tue, 12 Apr 2022 07:22:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 12 Apr 2022 07:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1649762527; x=1649848927; bh=KP
        ZFl+zUr69t/646Egboka8UL5M06q8AkE3vXXNQoBs=; b=pX+4232Q9TXW4yP/a1
        R1BxNARz4dR7D5YCwTYdaxr8INFIhb6PIbl04Xt5SNCHXNRHrZRnpT2dvlHbGwOU
        I6AILER+nvsN0bABWf9bKj6a4yiOvXJC9a14I1RxUmCStSqRgpOTbcLdTeygZdly
        m2pWlOMsLVsXx2AWtJKdnVkL3nZQo1yRuTLpKeKmrrFY+DZiSq0/QC6aHJ+R7aM3
        8EwXfSAckZ7NQZrtA0cwzB912d+SriEG+XbkA4TBmmOBxVuWIr9tdnEnYoAgGk0m
        xcNAru2x8O+lppc6f8XeJDA1R0PoFMJswevoGuDDPqAVC+828OlJGsrIR9w7DwB9
        2/2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1649762527; x=
        1649848927; bh=KPZFl+zUr69t/646Egboka8UL5M06q8AkE3vXXNQoBs=; b=Y
        9uncMXn45ChqGDxw2b0yQ2I94QzNXR7JpqEVynwVDzS2+cpO+udMiLWZ/xckC/iq
        CMXKS33zrHvkxDQuDEgphtKEI+h8rEFw+v4UTZbtic2/mmDRm+Wf9qYkbblVtP85
        3f7uJU1cTxpM5pmTKRw72vkKFLywOGaLMhDThlUswG9nj9iCzoKJSt9muDpGALnj
        MAZbH1oKBjF7p2gJJYXFGJ6GmtM1iIjppOGXxFWdO6CPMwAREY4/OJY9bOq3sxyd
        yKbh4q88tMV/QVqC3Z8/4pjZyrd/JrQgWTDGmuhQVMSC068YvuxONAJsW8f13B72
        5wMgyJQX8fdBPmArOua6A==
X-ME-Sender: <xms:32BVYlCrjQaPzYvPv4vqKOcGH9ZCUAXn2ZN1i1bTuPVPyWj0TPhQQw>
    <xme:32BVYjjt8aeiWoaD4luldVl5THVoqekv3B1Z__LNnnhVN0pUOFP2hCXLjJzA4q5Hk
    ovptberySGlFxm_wOY>
X-ME-Received: <xmr:32BVYgmpIhT0s0u6Lhz4qfmwtPwfF05PNdc0zbxz5U2-f_rgpR-a0G3V2nHix00KU6MplkTWqSNZthBLXnjyOHpaSzLV8wQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekkedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeelhfeugedvjefgjefgudekfedutedvtddutdeuieev
    tddtgeetjeekvdefgeefhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:32BVYvx6z53PZlSYybX2_mafXMos7XQZvTr45aetqSXm2kUwUny-rQ>
    <xmx:32BVYqSJab63oi5Z4eGeu2vcxLWABnZLnOhe2YJwGpT_6fSRt2pWTQ>
    <xmx:32BVYiaPr4CXRM0Tvvlu0qw4e3ytFHvpvmbFoL9q40H4uRLISXcUxg>
    <xmx:32BVYlenlpUsI2pcOriw7JETAvYNGXr5178WFBhJLV19DeeFR2IqiA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Apr 2022 07:22:05 -0400 (EDT)
Date:   Tue, 12 Apr 2022 20:22:04 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [bug report] firewire: add kernel API to access CYCLE_TIME
 register
Message-ID: <YlVg3I8kLIcBLZAE@workstation>
Mail-Followup-To: Dan Carpenter <dan.carpenter@oracle.com>,
        alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20220411070124.GA12881@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411070124.GA12881@kili>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 11, 2022 at 10:01:25AM +0300, Dan Carpenter wrote:
> Hello Takashi Sakamoto,
> 
> The patch baa914cd81f5: "firewire: add kernel API to access
> CYCLE_TIME register" from Apr 5, 2022, leads to the following Smatch
> static checker warning:
> 
> 	drivers/firewire/core-cdev.c:1235 ioctl_get_cycle_timer2()
> 	error: uninitialized symbol 'cycle_time'.
> 
> drivers/firewire/core-cdev.c
>     1209 static int ioctl_get_cycle_timer2(struct client *client, union ioctl_arg *arg)
>     1210 {
>     1211         struct fw_cdev_get_cycle_timer2 *a = &arg->get_cycle_timer2;
>     1212         struct fw_card *card = client->device->card;
>     1213         struct timespec64 ts = {0, 0};
>     1214         u32 cycle_time;
>     1215         int ret = 0;
>     1216 
>     1217         local_irq_disable();
>     1218 
>     1219         ret = fw_card_read_cycle_time(card, &cycle_time);
>     1220         if (ret < 0)
>     1221                 goto end;
>                          ^^^^^^^^
> "cycle_time" not initialized on error path.
> 
>     1222 
>     1223         switch (a->clk_id) {
>     1224         case CLOCK_REALTIME:      ktime_get_real_ts64(&ts);        break;
>     1225         case CLOCK_MONOTONIC:     ktime_get_ts64(&ts);                break;
>     1226         case CLOCK_MONOTONIC_RAW: ktime_get_raw_ts64(&ts);        break;
>     1227         default:
>     1228                 ret = -EINVAL;
>     1229         }
>     1230 end:
>     1231         local_irq_enable();
>     1232 
>     1233         a->tv_sec      = ts.tv_sec;
>     1234         a->tv_nsec     = ts.tv_nsec;
> --> 1235         a->cycle_timer = cycle_time;
>     1236 
>     1237         return ret;
>     1238 }

Thanks for the report. Indeed, it leaks the unidentified value on kernel
stack to userspace. I'll post fix later.


Regards

Takashi Sakamoto
