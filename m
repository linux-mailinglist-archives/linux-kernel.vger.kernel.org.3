Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AC54DDFC6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 18:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239590AbiCRRX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 13:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbiCRRX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:23:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546CC2DF3F2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:22:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 185so363441wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thejof-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+VzERDRD2VoZoiF515kWIEdg0Q8IlHEVAiLNL41ewM=;
        b=IEG3ZMzLtSLcb2jnUs7+7Ulw+8F0IdF+q1jlkT87NJzdf5g4YSAHtVDLKR2SIQuJIq
         kuxguDmswWjbjtW/vQiLUqDALuP2ub9CecNUQn1/oGqfDUgys7tEAhj6So4XXS1ERunR
         XdPmqmlXd8vzQrgWmAkE3T1zsdV949NoiVFqyR7Mf7j8O5uqNhfkdPP+RgAenO1lW3pz
         vnplM9kRgfZVrNzMz9nHgchuyFFBQus9JevB6WQEFjUDD8E5IwOp+YuHfiWJTj1eNCK0
         C4X2/YkgWhmW4FhthKtkhVO0EpCjUxv81kGl3lF8VOpvqPe8WtslM+AA3VfXLxtLU8up
         CI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+VzERDRD2VoZoiF515kWIEdg0Q8IlHEVAiLNL41ewM=;
        b=v0dSt+iK1TbTqEE0pgS46RlQTVJzEKrrpgwkOJPDmiHN2xTSSIOVC5+09XcExm+LQn
         dCf+VDwz/JEORT8JYcGJbNSmCtOCk8AK5I+qXl8GCOrX+VVqGrcNtvexPxKvh5obM5Ie
         DVWJxh74fqd9KiYAEwp6Lxe6D01aYqUD9xuZ5evYrlEOr0Hcbuh6yOJQyrrZ+MMwimQD
         MH9sNmhStdf3Tky9NpxIQVHZAFTH9Zzd/4DhZSxKRyFNotKMLWpbWeCFrMuiMLMcrVPi
         usl5X0fS33bXzlKbFoWeB7QWDQNhb89lUWFmXMvpo6vKj2PQXCUctw72WC2jTcVlsytQ
         6qPg==
X-Gm-Message-State: AOAM531ipOsPCjbYp9ZVGKMybub+WQxradhtSk24vgluH0WXY9g529N7
        abT4KfgGD/7larRF2iWTX8QOWeai2+iKRjcGMOsapw==
X-Google-Smtp-Source: ABdhPJxgHn2sZNxHWP5uV7VdFK91bGWryu5zubtsi5xAgc+1zvOVXL61Y0Vy+clK8I0B37wvA95VORgbJ+1oaun45G4=
X-Received: by 2002:a05:600c:2e45:b0:38c:8854:252f with SMTP id
 q5-20020a05600c2e4500b0038c8854252fmr3915925wmf.78.1647624125759; Fri, 18 Mar
 2022 10:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <d9aee29aaf11f4a26356e9f1c844b40cb4a7a63d.1647537330.git.jof@thejof.com>
 <87r16zn7t2.fsf@mail.parknet.co.jp>
In-Reply-To: <87r16zn7t2.fsf@mail.parknet.co.jp>
From:   Jonathan Lassoff <jof@thejof.com>
Date:   Fri, 18 Mar 2022 10:21:54 -0700
Message-ID: <CAHsqw9vhuD1+ZWUZgzg5ngBVyusSVLHGcWJ_Vp0k7oeKfxiHwg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Add FAT messages to printk index
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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

On Thu, 17 Mar 2022 at 22:33, OGAWA Hirofumi
<hirofumi@mail.parknet.co.jp> wrote:

> Looks good. I prefer removing duplication of message prefix though, not
> strong opinion.
>
> e.g.
>         #define FAT_MSG_PFX             "%sFAT-fs (%s): "
>         printk_index_subsys_emit(FAT_MSG_PFX, level, fmt, ##args);\
>         _printk(FAT_MSG_PFX "%pV\n", level, sb->s_id, &vaf);
>
> Anyway, if this is same style with others, it is ok.

I would agree that defining a macro for the prefix may be useful. It
could be a nice hint to future developers that these things are
somewhat connected.

I can follow-up with a PATCH v2 to include what you suggest.

-- jof
