Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE474B2D28
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbiBKSwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:52:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiBKSwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:52:44 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928DA389
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:52:42 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id y5so17824708pfe.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=0FQei1pY0LCHqipBs4sfkYiChk/zz8y1S+0ZsU19zEU=;
        b=K5CiLU5WhgRjmRs1DCvUJTCXND0gyRLPtQr3+M83VzP++0jx36Km/ZH5R55/BnPsvF
         9faqVoGMJnqxWSwKQV7A13B67u0G+g+zD1Snh8a0QLYxtTnKAmrspUH4q6r3jhZsjV4S
         KDX9+WZRAKGwdKAeK5+UpzNDveeZb5zYZeqb6R23sM5luVZP/Hq8eN5+aD4HoWNT+540
         JGdUiexPkWpCCKoUQ6aT9PZ7PkGWE9v/5LQ9C/KBO3+/KMArcLOP+HsffkojZon+bgck
         Uun9Y14pRIeaa9ZbajwhSmRoLyWlDTnqTcZaZcTlRwTNFfRKvl/Y+vAoGn8Uj2toDxcR
         vbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0FQei1pY0LCHqipBs4sfkYiChk/zz8y1S+0ZsU19zEU=;
        b=ZNLtupCCugn0EgRlx23rpP4KkXLTSk4STBAnG/Tqzq6ks2r/j9cPT1niG9EQFdTv1j
         ewd67l+JYHIh4GQiFQ7pFpuLgexpZLyqjphnA2VvHd4jEh8VPgQ5LPcxEU+O9P7QcyDU
         HjuEgVF4JxkUgLtB5Og9HM95U5wR7I8VBpxGkVoryCrIzXM9lTMc9VDqtaMKHUqGceu1
         x1QSPODG3P1F4lm7eowwkkCywqnb6HqA1qbMLNOEsScEaxeL4WT+azYc1Y50bGB5ivIk
         PYGbWogBzphDXEsj+F2l81TBq9sjtf4dZKWMo1nHlL1azZDQSbIIiJadNTD+Ll1Wt1Af
         OKNQ==
X-Gm-Message-State: AOAM530kTeSgB8/ljYUhqmP7s/pGjX7Ryni/5mxGjpBlPmLx/gunb6sW
        nXZ5wjCNZY9ro3kJFcPUiG0qNQ==
X-Google-Smtp-Source: ABdhPJzp++F6L+Noa2Fd1DjatakG9PMYKetKo1YRVAGNl0SGHnPZ2qELdIdPw6iIhfZIPw5sFm+YIg==
X-Received: by 2002:a65:6093:: with SMTP id t19mr2449132pgu.584.1644605562030;
        Fri, 11 Feb 2022 10:52:42 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id k16sm28170462pfu.140.2022.02.11.10.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 10:52:41 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     "shunzhou.jiang@amlogic.com" <shunzhou.jiang@amlogic.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        jbrunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "jianxin.pan" <jianxin.pan@amlogic.com>
Subject: Re: Re: [PATCH 2/2] soc: s4: Add support for power domains controller
In-Reply-To: <2022021117375354230910@amlogic.com>
References: <20220126061018.705338-1-shunzhou.jiang@amlogic.com>
 <20220126061018.705338-3-shunzhou.jiang@amlogic.com>
 <7hzgnal5yu.fsf@baylibre.com> <202202091001287547451@amlogic.com>
 <7hee4bok8w.fsf@baylibre.com> <2022021117375354230910@amlogic.com>
Date:   Fri, 11 Feb 2022 10:52:41 -0800
Message-ID: <7hwni1me12.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shunzhou,

"shunzhou.jiang@amlogic.com" <shunzhou.jiang@amlogic.com> writes:

> Hi Kevin:
> Thanks your kindly reply

You're welcome.  For future reference, please avoid top-posting.  See:
https://www.kernel.org/doc/html/latest/process/2.Process.html?highlight=top-posting#mailing-lists

> For those domains,  default is active, we hope not close when in use or not in use, in our case, 
> only runtime PM (include suspend) control this, so set always on flag to avoid domain shutdown,

my question remains: why do want to keep these powered on even when they
are not in use?

The goal of the power-domain framework + runtime PM is to be able to
save power by turnin off power domains when they are not in use.

> if you also have concern, we can control this not in kernel, but this not our expect.

My strong preference is that this is controlled by the kernel.

Kevin
