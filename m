Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1964EEC04
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 13:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241854AbiDALJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 07:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiDALJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 07:09:02 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC01331523
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 04:07:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m18so2197181plx.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 04:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+r6EP28f/Ptl0csP22+k8TOn+cpNh4f5hWwYK7TTSKA=;
        b=iijLDK3zC+TKzZaBhyuhlKBcwdXaxfcB6TImilqgECvS7TbqFpaUr7gZPzyLA73Xfc
         hJPE5bsFnstbGHX8K1YUd8WqfDwNfvs+pBtctDG0kc2OSgg+HFrEZ1VEaqWG5UXmLntP
         W6TQcSkBWmoQGXrPeFC21Qm69da3R9kje/85Gk5JLMKgpZooo+H3uLeGcMFP/Cj1184t
         kQv+9X4dU3I3CsgkvLdHFM4o+WtE0feJtzcGovDC7h0+iMg/xFq/qe+/XJ7430asSJXZ
         E+elxO2axZzi1nt91ER2meWfA6d6t31dNXRtKrUGnKYsB3rryeDs4eVbfgQwO5OnBdJg
         X12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+r6EP28f/Ptl0csP22+k8TOn+cpNh4f5hWwYK7TTSKA=;
        b=egqxWfmZ0sfIZOvT/h6wSWe6HCLgiideqkg1OhgtgrldBKF7qnLE1MMPqIteZ9ZxU8
         J/ZTiaDSW3DAVzFpdWJxyiLoZMEgKwzax+U7IJnUXSRFZVpMytiR5DHEDb0o6XjwA9Wc
         c7HPoFhALHdELI5XskSSKi2uBisKLcmhdyhYQar1VQ82569/aqkDpHjWTQlRmq8nB9W7
         a+WHB7De+xi4eez+DFO79H2ufQXqomx4+yM4pbanfXSelcG8ChnO7CABcfg2voYwLBV5
         ce7fj05EeF1SqBZEIVomsvwrddW2TJg0aeDOILICEd2clkti9BVE4D/btWUBOowr+9ra
         cwww==
X-Gm-Message-State: AOAM530HFA7Pi5NLcutY5+1nk+ytlEjJ2v6vljcU4i1i/Tl4BONuCV34
        GsP4X6q4qtXRySJx7n+U2GVaVpn52hCsbg==
X-Google-Smtp-Source: ABdhPJyqGpeymcKcQPbQQ81k4IAWaUMQseP4GGRfubj2qw8Ovl4u1ketATNHziS7SSzYRO93zRIPbA==
X-Received: by 2002:a17:902:bf07:b0:14f:a3a7:97a0 with SMTP id bi7-20020a170902bf0700b0014fa3a797a0mr9999300plb.105.1648811230357;
        Fri, 01 Apr 2022 04:07:10 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id y12-20020a17090a784c00b001c6bdafc995sm13243426pjl.3.2022.04.01.04.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 04:07:09 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     patrik.r.jakobsson@gmail.com
Cc:     airlied@linux.ie, airlied@redhat.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        xiam0nd.tong@gmail.com, yakui.zhao@intel.com
Subject: Re: [PATCH 3/5] gma500: fix a missing break in psb_intel_crtc_mode_set
Date:   Fri,  1 Apr 2022 19:07:03 +0800
Message-Id: <20220401110703.7951-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAMeQTsZnNy2ToRNTBisxVwBnj8Hsdz7+zdgcW=yr8C=zbAJZhA@mail.gmail.com>
References: <CAMeQTsZnNy2ToRNTBisxVwBnj8Hsdz7+zdgcW=yr8C=zbAJZhA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Mar 30, 2022 at 2:03 PM Xiaomeng Tong <xiam0nd.tong@gmail.com> wrote:
> >
> > Instead of exiting the loop as expected when an entry is found, the
> > list_for_each_entry() continues until the traversal is complete. It
> > could result in multiple 'is_*' flags being set with true mistakely.
> >
> > To fix this, when found the entry, add a break after the switch
> > statement.
> >
> > Fixes: 89c78134cc54d (" gma500: Add Poulsbo support")
> > Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> 
> This patch doesn't apply for me and needs to be rebased on top of
> drm-misc-next or drm-tip.
> 
> On Poulsbo there should only be one encoder per crtc so this is only a
> theoretical issue. But it is good practice to exit the loop early if
> we can so the patch still makes sense.
> 
> Also, please use the correct subject prefix: drm/gma500: instead of
> just gma500:.

I will resend another patch as you suggested, thank you.

--
Xiaomeng Tong
