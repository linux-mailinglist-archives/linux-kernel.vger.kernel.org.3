Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEBF4E5FBA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243128AbiCXHx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348732AbiCXHx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:53:27 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFFE996A2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:51:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p4-20020a17090ad30400b001c7ca87c05bso40452pju.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pu00Wt7t+7SgrwxKX6S64r5ey3zhRw/tKWIDbQLLHnU=;
        b=ojF6jN6FPzADkF69NIviFCqlkD0B5s441uEag3GAlD40cW4lJZVW2AqzYcQVI6fvJc
         y2oIi8eL/PQ2Ejk4dqdKliziyz7uSG/7umM0DEBK5fXajegRM+21US1YIWRo0T+3DLjI
         cR+GXdjtiO5en7xywf1rnm9Q5O+aOIrOZS0MUvBfpAhQ7kmi5hmfBt6iYAS+iY+QfEu6
         5Np87P5log4ZGrmJ2NnRPitBEFyCah7+4bvdN6efEleE5bxEO+JCAHbTtkFyu8/8+SSk
         bVaxR33bblL26CnTmxIWZCxQoImPHtF7RiIOnZMU87oN5DL5AGx3DW+6Sw7cApMjRD6C
         1NXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pu00Wt7t+7SgrwxKX6S64r5ey3zhRw/tKWIDbQLLHnU=;
        b=j4ITOeY4rrxxf8DL9mohT7wDu/B5gwD/TRmM3CUa9Pbox8hESKSp+2zfK6H1idaXA9
         v83gMDolj25lQxCcwrELqdNMloPKOgL0VpYMA70FgDYUju5vVRtVihLCWXwFWSlOOpnP
         oDgurMmNmjZLjauizT2wLLNQW91UmSn429qhi61TfEtHsqBz2T8FO+3hvQ8ICSwMFksE
         8FzI8/kbJEi0Rv49g49k9B7YYktHKvtA5dbc8lx3k5JCiqL8ISD7g2l2BHorgC3VOpBE
         0dEtdlWmVgcsSi73oerbx+snJp0dA4oZWrMhj3whon9MsFvltAkNlf3dQUxPsK4/Eulr
         hlwg==
X-Gm-Message-State: AOAM530a6egOohFoRXsw1Gm9jrP+JRvZwo7x5Ifwh34VqhdniDxYYj1a
        rqQ6oGabLKTNUUkFJJ6pNyE38pZSUL7qgWDKmAFZHkv+aIWTkw==
X-Google-Smtp-Source: ABdhPJwF9vUdTNhlcu7amXjm8S7YDp9GZJV7KKDCtR77DoilLycYmSpRd7n+ibYFvaziJGbJiudFQA4pb1OUAH8q6nc=
X-Received: by 2002:a17:90b:4c92:b0:1c7:a9a3:6274 with SMTP id
 my18-20020a17090b4c9200b001c7a9a36274mr5439038pjb.148.1648108315505; Thu, 24
 Mar 2022 00:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220308133505.471601-1-clement.leger@bootlin.com>
In-Reply-To: <20220308133505.471601-1-clement.leger@bootlin.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 24 Mar 2022 08:51:44 +0100
Message-ID: <CAHUa44EVLYiA6u4QVyPQTnK0-=4UgL-RK4i=wDYfQW9daCCkvw@mail.gmail.com>
Subject: Re: [PATCH v4] rtc: optee: add RTC driver for OP-TEE RTC PTA
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 2:36 PM Cl=C3=A9ment L=C3=A9ger <clement.leger@bootl=
in.com> wrote:
>
> This drivers allows to communicate with a RTC PTA handled by OP-TEE [1].
> This PTA allows to query RTC information, set/get time and set/get
> offset depending on the supported features.
>
> [1] https://github.com/OP-TEE/optee_os/pull/5179
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> ---
>
> Changes in v4:
>  - Remove error prints except the ones in probe
>
> Changes in v3 (was resent as a second v2 due to a mistake);
>  - Fix error messages to include ret value and fix wrong IOCTL names
>  - Use 100 columns char limit
>
> Changes in v2:
>  - Rebased over tee-shm-for-v5.18
>  - Switch to tee_shm_alloc_kernel_buf()
>  - Use export_uuid() to copy uuid
>  - Fix warnings reported by checkpatch
>  - Free SHM in error exit path
>
>  MAINTAINERS             |   6 +
>  drivers/rtc/Kconfig     |  10 ++
>  drivers/rtc/Makefile    |   1 +
>  drivers/rtc/rtc-optee.c | 362 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 379 insertions(+)
>  create mode 100644 drivers/rtc/rtc-optee.c

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
