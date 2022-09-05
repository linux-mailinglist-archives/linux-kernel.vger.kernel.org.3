Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4835AD88D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 19:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiIERpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 13:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiIERo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 13:44:58 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE8115A39
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 10:44:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id io18so373106plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 10:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=Kdy7srNKCtjeqbxb9BysqC1LCV20DOnAdYhn3wpUgz4=;
        b=xS/5n775MFoxRJcoj6fIp9Z/Y1S/RZ13V1LaX5TDHTIjCGHkrnnFN1M6XKJPYOZvY0
         uvNhozEkZV0q0+hJbiSp8h6L6t+bi8QoAOoteh8Br01AgaDSWze+c61NbmVyiyDuuxKY
         yECQNSGs+pdanmOFcpN8yAUfkiFZdJy/OQfxJvKe1GR110ci+vlk4u995uB4yC9Jav8U
         tDSmCPeVlnW28ZshErkbiT7Pys26f3Sev4jwT9OfZVsXCuUl6iEFmviTGyFiABbLjagQ
         k5bWhRhS3QQzRW3ToGbH9yxhKtidgcKsKV0HsNEWlwauEmcOyHEzQAj4srpFzNlb9K/K
         dDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Kdy7srNKCtjeqbxb9BysqC1LCV20DOnAdYhn3wpUgz4=;
        b=dqpHoV/9hmkckRBxZfqgsntm4u4N66dIcGl95KJX5EeeBSZrmdwW63GdaL7e9+b3F9
         mbkGrgzVf1W58P45EdYyExROvUWVclLpPz+wMGmN9+95UiY9PMthF1Ly2QqtBprBCtPO
         CXmsuf3Upq0yfwvUSVCAhNlbgpT6yXDjucXQx4FELQX0pKX/EGyDlv+thfPuI2d2GK6w
         cx28uxO452E1Saur7rpDgNBQ04ViDtntcBzmBQnFkmprq3FDYS9Cs3zSefw7Z81JVMyU
         ZEyDpW45br9byiehhuPn9rn/5lMUNyRrYTxziY6pkyTSGz1NaDYGMqLcsxRyP4cRc/wu
         Mu4g==
X-Gm-Message-State: ACgBeo0opovUsYW93+oXcOqK2P+6xVupd3Rd1B7cGvyRc8DPPxPWSY/j
        V687Qyj66qBQCoCY6yPDU0gPB2WQdAIBbg==
X-Google-Smtp-Source: AA6agR7gZ8e1eP+vIxgWOjpFysLPO8oTFhYe41YOx2ZynSWONvcXp6us67T35FK2FML2yjA4z5ud6Q==
X-Received: by 2002:a17:90a:8911:b0:1fa:c8f7:1450 with SMTP id u17-20020a17090a891100b001fac8f71450mr19984246pjn.123.1662399897297;
        Mon, 05 Sep 2022 10:44:57 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902e85200b001753eb6668csm7877143plg.251.2022.09.05.10.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 10:44:56 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220905063253.120082-1-jiapeng.chong@linux.alibaba.com>
References: <20220905063253.120082-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH v2] block/blk-map: Remove set but unused variable 'added'
Message-Id: <166239989655.374444.6422945735649090194.b4-ty@kernel.dk>
Date:   Mon, 05 Sep 2022 11:44:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Sep 2022 14:32:53 +0800, Jiapeng Chong wrote:
> The variable added is not effectively used in the function, so delete
> it.
> 
> block/blk-map.c:273:16: warning: variable 'added' set but not used.
> 
> 

Applied, thanks!

[1/1] block/blk-map: Remove set but unused variable 'added'
      commit: 91e5adda5cf4e3bf21c46eaa2ae7ee2cb6058126

Best regards,
-- 
Jens Axboe


