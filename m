Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0434D5B08A8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiIGPf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIGPfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:35:54 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7A87F08E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:35:53 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1225219ee46so37021968fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PJ1lWwYFEszOksy6cokuR8knQTs448skT/omVPFCP8w=;
        b=w90Vv5+9jPACTKEJZFVsTzToEB9I04PVAqCTysyYU8AP1NtTaTwXnKwnKTRpOqGZKo
         19tV9o41YfQCpIMgUqhhtemlgFCy4uZSMS0KE0UDCaHVyZ8cB1BhwXI0Vu6FucxRte7A
         Xnqz89akA3AtlT5apR915z9t/mNoS3ZbOJKaSAlSJF6EbYSPes3dEaZiLjy7GKu1rnvM
         bHeshipj36+PUc/d8geN3WHqCOiGzYLSTBC41X9oCIJPYptE33J+g6tDbyGsT3h6IYcR
         xSyoPSn79NybB3etT4DU/bnZRXF1NyjwrLzXwoW52Z68c94m6jHC7K4zdHkB3X8a0p7s
         MEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PJ1lWwYFEszOksy6cokuR8knQTs448skT/omVPFCP8w=;
        b=BAKPQtyh/Sg5d50VQ4hL98WMtKXWkOQXP/BJBiiVvg8AxiIKcZbrELitX4rOHtcKNb
         B0uieQPza5N/uGGJZJ3UMJ2ZTEhw8nxXxHLf0PCTh5v/+04WXepoMxdgZs09k/IWN2j0
         NOJMTXBKMur7InzLT9xgmPTpBhZDSzAXqBhpPz0vQH/THi88D5qvZBQirrrfNcJU2F+5
         0VTL6v8IgUPVcQqLUMfZwSw1tZ9/XRp5lJ7F3LwtsTK9BVBscG70pDXBV9S4CywfAEOC
         cPY2pJ4LhCPrAeE3i1irQllWxZhulbquDo2f9eLSrZg/OGV4ijCx2+H4FdPBmvyptTVM
         w7QA==
X-Gm-Message-State: ACgBeo3Q6a3Ihrw8vs+HgYHIsjYI2EDrAtCVdmstAuyu5+RsvrzBCmfI
        ERzqtrERzdVunDlSJCKIc9K2P87kxQ78Nx4CDfhyFXMEqg==
X-Google-Smtp-Source: AA6agR4+ywDFjNwdQSwFuXdKoygZzrgV92cis0aiVF7by3y0naQvO+RISGoVDoBlGVszCnQOUgz/P7tBncFBFdJ6qNc=
X-Received: by 2002:a05:6808:3a9:b0:343:4b14:ccce with SMTP id
 n9-20020a05680803a900b003434b14cccemr12552608oie.41.1662564953184; Wed, 07
 Sep 2022 08:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220906132508.112248-1-xiujianfeng@huawei.com>
In-Reply-To: <20220906132508.112248-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 7 Sep 2022 11:35:42 -0400
Message-ID: <CAHC9VhSgJ2164Mr_bvNedKX0ANWRosgX_R+MfRSTzFsR1WJOQA@mail.gmail.com>
Subject: Re: [PATCH -next] audit: remove selinux_audit_rule_update() declaration
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 9:28 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> selinux_audit_rule_update() has been renamed to audit_update_lsm_rules()
> since commit d7a96f3a1ae2 ("Audit: internally use the new LSM audit
> hooks"), so remove it.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  kernel/audit.h | 2 --
>  1 file changed, 2 deletions(-)

Merged into audit/next, thanks.

-- 
paul-moore.com
