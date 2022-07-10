Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA89C56CF6F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 16:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiGJOWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 10:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiGJOWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 10:22:11 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCDD11811;
        Sun, 10 Jul 2022 07:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1657462927;
        bh=UEHzy2UOGNOI4erbhTVIqhEBR1G0jFo5sbobopAQmCc=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=xi3D1kEvoEXnShgXHBpH9GzWpq1xih4Hjv8jUVNvMVul4NSMUCEOQGkQNE1Suxx/b
         9fmX111AWjz28ipisp23a9SsRjTFYYJCV3E9+gTb0ydaxhVSQFSXBBiaHdyFwY/BtC
         h8plGxBbj6+nvOy3aTffQ+TdTT/r5eLGYzVAsIT4=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DD4741281218;
        Sun, 10 Jul 2022 10:22:07 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4jJXjst3V0te; Sun, 10 Jul 2022 10:22:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1657462927;
        bh=UEHzy2UOGNOI4erbhTVIqhEBR1G0jFo5sbobopAQmCc=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=xi3D1kEvoEXnShgXHBpH9GzWpq1xih4Hjv8jUVNvMVul4NSMUCEOQGkQNE1Suxx/b
         9fmX111AWjz28ipisp23a9SsRjTFYYJCV3E9+gTb0ydaxhVSQFSXBBiaHdyFwY/BtC
         h8plGxBbj6+nvOy3aTffQ+TdTT/r5eLGYzVAsIT4=
Received: from [172.19.0.226] (unknown [75.104.86.111])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1B70B1280361;
        Sun, 10 Jul 2022 10:22:02 -0400 (EDT)
Message-ID: <cec12e246d7151f6041bf553629a3047e81d4afe.camel@HansenPartnership.com>
Subject: Re: [PATCH] drivers/ata: fix repeated words in comments
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>,
        damien.lemoal@opensource.wdc.com, s.shtylyov@omp.ru
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 10 Jul 2022 10:21:56 -0400
In-Reply-To: <20220710052203.12349-1-yuanjilin@cdjrlc.com>
References: <20220710052203.12349-1-yuanjilin@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-07-10 at 13:22 +0800, Jilin Yuan wrote:
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 3307ed45fe4d..f2ac8340e769 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -863,7 +863,7 @@ void ata_eh_fastdrain_timerfn(struct timer_list
> *t)
>   *
>   *	Set ATA_PFLAG_EH_PENDING and activate fast drain if @fastdrain
>   *	is non-zero and EH wasn't pending before.  Fast drain ensures
> - *	that EH kicks in in timely manner.
> + *	that EH kicks in timely manner.

The original is correct and the update doesn't make sense.  Of course
adding an article would make the original read better ...

James


