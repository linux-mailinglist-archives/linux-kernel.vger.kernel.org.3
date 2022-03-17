Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E89F4DCC4A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 18:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbiCQRWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 13:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiCQRWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 13:22:30 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A1021045F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:21:13 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id i11so4317279plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GVH5wVAAit8dSLwq1mNIRCt3Jo09Ih9fX4BoyZZKgPQ=;
        b=iTFoidxbuOT1lSI7/Ijmymp0fz5i9LCFVj36rYqM9/RnB0fdLmDulWRgpkR3cB/3lE
         5358Gi6sMXZLRVf9CO6aC4XxLmiTrrRBkJm+OfNr30V6mEBuXo4NuX0XBgxJqNWDNzdK
         jIBT5ZIec0zweLFylC+8GTTCFvuTmcTsAs4PmgxWAc6FdDeLM9VeztG5YtpfgBGulohF
         fQ2+aNlr7RlidLrQMM2MsCSpiUrPMfzXkhHrT+zdxwnV8XEt4Ai6ToeQ9g+kcuBVG+7P
         ARNInrm8U/jSAbwxhsCkeDkVlybyKPBeIE0FCyJkDXbr2LWHutpKbpFDe9Cu+VA8Esmi
         64QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVH5wVAAit8dSLwq1mNIRCt3Jo09Ih9fX4BoyZZKgPQ=;
        b=nR6SX51Mzo33QDQ9XSozcYCFvq4OxGSsnn0ZtRrQqxrqNDeapfKmgBdlgl6X5GqKRc
         Zdt/ss4Bx1ixETIgu4r4baiNsmFnwM1J5pJ6aK0qk8fsDsCRfQ2y0+EdyFd41XgKBms2
         qFqJhrqcb49fCoyQJBOD+41uElzz6HzkLdRVJyWeQaL4oHoLldPXxE0RAeAkIF3JpXFS
         ff2dLl2sALH0vC2hIHMKPcYvhyYIU9A5R2R9jpKSw+y0jjaZaHHnqZMAxOjnhAFcOQ/8
         MEhTAf5gNCCQIKMgcS1eaz16JgU9bs39cfiSmhG40JbC4x7wU9gMoUwAMXlO63698EZT
         X7Ug==
X-Gm-Message-State: AOAM533C+aCEAy2Cz/uy8YBlF15V/2qDeskrvS/mjzJKj8zJylcvUb6b
        O6FfPHOYU2dy+fw0MuV98I94VR1HFYC1tRFPl2Udww==
X-Google-Smtp-Source: ABdhPJzqgsPT0hwjxBN45Gy/9OR0t7APqndu9r3X2Xqq7QlDima8SHekoYP4JM8Hssel7QLwL+wIFHPwKWalxj6/VC8=
X-Received: by 2002:a17:90b:124c:b0:1bc:369b:7db5 with SMTP id
 gx12-20020a17090b124c00b001bc369b7db5mr17253678pjb.179.1647537672934; Thu, 17
 Mar 2022 10:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220317094724.25972-1-yuehaibing@huawei.com>
In-Reply-To: <20220317094724.25972-1-yuehaibing@huawei.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 17 Mar 2022 18:21:01 +0100
Message-ID: <CAG3jFythpVSh-CLuBAu8AC403Yq7Sh-oAjjkPtA+JFuN7_OriA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/bridge: it6505: Fix build error
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        Hermes.Wu@ite.com.tw, allen.chen@ite.com.tw,
        angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Thanks for submitting this.

I think this[1] patch should solve the issue you're seeing too. Can
you confirm that[1] fixes your issues?

[1] https://lore.kernel.org/all/YjJXnzJmDGsrZAXj@xps13/


Rob.
