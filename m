Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7845911CD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbiHLOBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiHLOBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:01:50 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CEF9A97C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:01:50 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id e127so1594624yba.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+SFgv9h1iU3RaW1EzL8Sx1GBNpviMfrfYSjOlKJNalY=;
        b=GexBwlzNcUg/qU5qiIjT+qVLabhItlMZab8kXhbIgYg/s9YqOoVrhlLXym1XIzz6Px
         Rk/RcoIczEJHjJ97VO0fTIPsq3HYyPVaW/JUIMNQ3cN5X/KmTDLGFCtxREsLBL1kWy5k
         GUARJmL+g5kLqA7tIYXDo9XtXSX4f+3BJX1JbJdmAck4z/iUxKOTWqtTOr5UiBmmNL0s
         NVZsUn5yWc2PEnvIy9Yqpg2lQDkclvsn72rdBGNwa7cy9OVzMz5JtbAwcV386nrB9Ufe
         QkAw64GzOwXZeuGlRILLthaFnMXQ1T8n8RRiuSz8NZzbZR/OM0XraZCMKwZT/Yzcz/01
         k7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+SFgv9h1iU3RaW1EzL8Sx1GBNpviMfrfYSjOlKJNalY=;
        b=GWIZDoKwANfTEQQetIcQbb6I4zk/FoydsmN4gvxGCKeYiI51W7S/E7DEVcCcJBEFzw
         UEOC4xb/RrZaQDwtTxe7La+YTVgTZozz3JB//8rXMHlxFaZnXriEPmN6o6l/8xYjmxV4
         x2eDb0+GOYXE8rkx9Hq1ptSykA62xd3YX/c3HdvH7ga7p1GGXu/PQBPHDEbpJ0AnhpiR
         tM7K19lu2XcN5jwnYfkE0kDRhj9njH8r7D/CrxFxVXPuQgs2Z+h6CMHbsnA+V5fipn77
         tTtYvLvTVdm3yrEJ1FKT23NQMBBIUQ5XibgS4DRBcirBCaS/2poFoBBkrMMaMQSUTbdO
         jNWQ==
X-Gm-Message-State: ACgBeo0+V8JUpTvTPIjuXB18XwXm9+TX0SK7gRpkSAbmvFgL33VrgCgu
        2zzWvoZyWa0rtixx3/jzEH/FEhrn9JHEVDHzXFwPQQ==
X-Google-Smtp-Source: AA6agR6wQfVo93oLxu/F6/VJXBQ5LP7rYTWu4LmoAHDNLeE2RTl1HyOisioe9Yvs8j7bCHes1v8fGpO512CYJNhfzF0=
X-Received: by 2002:a05:6902:124b:b0:67b:5d4e:c98d with SMTP id
 t11-20020a056902124b00b0067b5d4ec98dmr3734245ybu.475.1660312909389; Fri, 12
 Aug 2022 07:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220811135637.6332-1-olivier.masse@nxp.com>
In-Reply-To: <20220811135637.6332-1-olivier.masse@nxp.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 12 Aug 2022 19:31:38 +0530
Message-ID: <CAFA6WYN6TdTR+O7UXe3D=5-5gRt5h7VhFYpGtyGGge-k3e_ShA@mail.gmail.com>
Subject: Re: [PATCH 0/1] tee: Add tee_shm_register_fd
To:     Olivier Masse <olivier.masse@nxp.com>
Cc:     jens.wiklander@linaro.org, sumit.semwal@linaro.org,
        christian.koenig@amd.com, op-tee@lists.trustedfirmware.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        clement.faure@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier,

On Thu, 11 Aug 2022 at 19:26, Olivier Masse <olivier.masse@nxp.com> wrote:
>
> Add a new ioctl called TEE_IOC_SHM_REGISTER_FD to register a
> shared memory from a dmabuf file descriptor.
>

IIRC, here you are trying to fill the gap for OP-TEE SDP use-case. But
the use-case should be described here, its current status with OP-TEE
upstream and which platform you have tested this interface with?

-Sumit

> Etienne Carriere (1):
>   tee: new ioctl to a register tee_shm from a dmabuf file descriptor
>
>  drivers/tee/tee_core.c   | 38 +++++++++++++++
>  drivers/tee/tee_shm.c    | 99 +++++++++++++++++++++++++++++++++++++++-
>  include/linux/tee_drv.h  | 11 +++++
>  include/uapi/linux/tee.h | 29 ++++++++++++
>  4 files changed, 175 insertions(+), 2 deletions(-)
>
> --
> 2.25.0
>
