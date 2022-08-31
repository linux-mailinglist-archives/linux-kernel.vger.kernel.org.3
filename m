Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F66E5A7559
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiHaFA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiHaFAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:00:54 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF524D4EF;
        Tue, 30 Aug 2022 22:00:52 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3321c2a8d4cso297299047b3.5;
        Tue, 30 Aug 2022 22:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hP8w1oBDqJGAsXujKb/CVqCqGWT4GD4/gS/Uk4niIUc=;
        b=U2sDz1rAezdP1Sj5bHvd6szx1iNoBX0K5Wbnu3cW5OoN0uwMug+oJaS1qFsfwIj27Y
         9QnA5WX5EmaF5C4S9DZClPg090f0Q4WB7oj/zql033FyPO64hgVcJmz82ha61HGB9ui+
         pGGZAhhCdk1aMih0sPm6heP7qBleYkX9JUALM3LCooawCjqTyHM6KSfN+uCFf9/+Y465
         ZgsTK2945Bki0iqTqVbCdht/My8a+3lppMb9V5gHT6aZXzkymempomdgy715W+3ILsq0
         s29UshM1/lOqLLXHhw15oCDzWvyVsiIV5PBYqvseqX5FI0QHzWwc5apZf7BgELpJ53hR
         uwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hP8w1oBDqJGAsXujKb/CVqCqGWT4GD4/gS/Uk4niIUc=;
        b=kpowJHSmlo2RlsdjxlEWIeaEdl9rvikxjbSRWg/sZsJNzY66stV4ia+7RV2pLVhyuC
         NBFmyyXOpk3Z0G5QWvnYcRoXrTgh1lOvb3HKmwDkefNjC3B5k1+5oS/4yARGpQ0LyMzh
         5f5nxztATQ7wbehOVMa1HVA7Zs1wdBnkvuyQa1oQ3C1PQ1tpj/fETjm+E+ffSMgYjO3U
         BOCR+VAXEpZiHTB58LM1rDaXbtFgBU1ZnDvJwzeNA3NnMHb+pT50cP0prFmblcv7P3C2
         9EEHGLu4vkXnLrPxIa6JxI4dK1ahpAANsejmkh1w85SfW7I6S7hwVZv+jTYBq5rldvxD
         F9Yw==
X-Gm-Message-State: ACgBeo2WKa0gElrfnGxxPgI1P7Vp36m29hGXdAA2zgtTVonc7NcgWSGt
        Pw3vD324SDDojaZGM+rw2olqU1dRNBoGFwekNPQ=
X-Google-Smtp-Source: AA6agR43V4aiIKKAM0zrA3bkYsgumo2YxP7cn71v6O/qFUFZ/SaxVh9+QMKJg/zVg8qU5nYEmRLd1029vhYoWUpBiJ4=
X-Received: by 2002:a0d:d5c2:0:b0:337:5d95:8bcb with SMTP id
 x185-20020a0dd5c2000000b003375d958bcbmr16567963ywd.359.1661922051649; Tue, 30
 Aug 2022 22:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220831033403.302184-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220831033403.302184-1-ye.xingchen@zte.com.cn>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 31 Aug 2022 14:00:34 +0900
Message-ID: <CAKFNMokS2zV5hJsBkcj=wiSkOkVHiqT_jFi18aBFW_gbNHnP5w@mail.gmail.com>
Subject: Re: [PATCH linux-next] nilfs2: Remove the unneeded result variable
To:     cgel.zte@gmail.com
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 12:34 PM wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value nilfs_segctor_sync() directly instead of storing it in
> another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  fs/nilfs2/segment.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index 0afe0832c754..9abae2c9120e 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -2235,7 +2235,6 @@ int nilfs_construct_segment(struct super_block *sb)
>         struct the_nilfs *nilfs = sb->s_fs_info;
>         struct nilfs_sc_info *sci = nilfs->ns_writer;
>         struct nilfs_transaction_info *ti;
> -       int err;
>
>         if (!sci)
>                 return -EROFS;
> @@ -2243,8 +2242,7 @@ int nilfs_construct_segment(struct super_block *sb)
>         /* A call inside transactions causes a deadlock. */
>         BUG_ON((ti = current->journal_info) && ti->ti_magic == NILFS_TI_MAGIC);
>
> -       err = nilfs_segctor_sync(sci);
> -       return err;
> +       return nilfs_segctor_sync(sci);
>  }
>
>  /**
> --
> 2.25.1

The patch is not wrong though this kind of minor rewrite seems endless.
Anyway, I would like to queue this unless there is an objection.

Thanks,
Ryusuke Konishi
