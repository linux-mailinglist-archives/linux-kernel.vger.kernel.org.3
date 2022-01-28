Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698D749FDFD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiA1QYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350146AbiA1QX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:23:57 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD86BC06173B;
        Fri, 28 Jan 2022 08:23:56 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p15so17641572ejc.7;
        Fri, 28 Jan 2022 08:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbZKWsHJkalKhUpXu01Uv/vjdYsALlFDBYcY+6MyeMQ=;
        b=QzCBjF31P01lAnXfncXg51KSZ75EHiN6F92VXUsfEGTcw+KfdYSKZex/ygYm3fMI6U
         9k185flwZIQiTF7Lm0dCNYOM0b1xn4qRzUfBqwzajNNwMcDdxLAWDLtw19NZpPmW73F4
         pkGQqlFTeJUZOaaGGBOUyKyCC/lTgWESisGBOvCG6Qt8Yg8IC5L2NL6UOH/FgwflXxPx
         MrQuqSZZze4Xgq73WshcZBuudO2UdOJwIPEgmLf+ucnCvalzczdhkEcK96qPZHlMUrCD
         qi8h7Fg53g/KCQh0e8afQQK4i+9jKVcbF4Xx4lidr9koUQuWJk5ISr9ksyh/EmZsEroC
         Ck0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbZKWsHJkalKhUpXu01Uv/vjdYsALlFDBYcY+6MyeMQ=;
        b=0tY3BZGYdTsuDCuHwaTLjSaRHQyFbg4j1yz+tjHG9WY7RIlERmRboTGjIpfpNLmI9F
         91ngPdeTg6YdmN4iqa3LwsgYMFwK012zB9GTcYa0DxXJRu2M/S3x0XCdj9qWuCcJ0osz
         QKIsNK80QubPGbo7gi9p/vyDtYZtcxxS6qsIyno2LoiQclaxC7OJFsEgKJ4O/5QB1nDU
         +dSrzoKrKBaYgPcZwLk04zh3Z8w8YOjWRfhOOdX4PE6HC2P5QYkrLEcTe0JhmNeZyIUm
         UDQqZxTWQ9625lLxkl1CMugptDfaLuUIivo1EtL5besT0Hj60oaiAreoM2LjFnjU7/l8
         mS2w==
X-Gm-Message-State: AOAM533cDYNRjQuLVD0mSUTfysSs70vgSUuOcxg/UwbuPDecflGl0vtV
        VvLSMxN+hK884qn3lEHRC0CeP1bSMrv98V6lf30=
X-Google-Smtp-Source: ABdhPJwahl9ko5x+1BNqmFCRg8p0YyfdODE/JnyFQiQNl5j3ldPcUEGELox4ncL00U/q5JWJvFP7JqHpivc5xYyWlaU=
X-Received: by 2002:a17:906:99c3:: with SMTP id s3mr7712428ejn.696.1643387035286;
 Fri, 28 Jan 2022 08:23:55 -0800 (PST)
MIME-Version: 1.0
References: <20220128133649.1393201-1-usama.anjum@collabora.com>
In-Reply-To: <20220128133649.1393201-1-usama.anjum@collabora.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 28 Jan 2022 13:23:43 -0300
Message-ID: <CAOMZO5DaNpZbO2JS7KUOHJLAZNqpnY_ub8H_UF2sSHuQp-Ki0g@mail.gmail.com>
Subject: Re: [PATCH] media: imx: imx8mq-mipi_csi2: Remove unneeded code
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>, kernel@collabora.com,
        kernel-janitors@vger.kernel.org,
        linux-media <linux-media@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muhammad,

On Fri, Jan 28, 2022 at 10:38 AM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> ret is constant in imx8mq_mipi_csi_pm_suspend(). This function cannot
> return error. Remove the return variable. Simplify other functions which
> are using this function.
>
> Fixes: f0c2ba1ed4ad ("media: imx: imx8mq-mipi_csi2: fix system resume")

The patch looks good.

I would suggest removing the Fixes tag though as this is more of a
clean-up rather than a bug fix.
