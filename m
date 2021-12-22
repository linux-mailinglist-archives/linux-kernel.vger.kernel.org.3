Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2A447CB40
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 03:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238505AbhLVCEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 21:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbhLVCEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 21:04:22 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE00C061746
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 18:04:22 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so856754otj.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 18:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Al9bVe7ZlBBHxflPN7dDbRiQZxeGn2j4XWyGYUriWq4=;
        b=mlBAw9YdE/jogBzhUlrHKbx2cOXg5XI0v+CxuCs2lnBROr9s9cu+pUB+KQ8CzijjKq
         t9k/Xeeh3M7aUPlNUjMNfkDXxlKjRCUaTVQvAYgBxJp0TQZruoa2JjQKVSXplDS90yI/
         +0+v3XJHhw7ku3kr1ufQL+oZbL4HU0hrQCmF4vm+rdYPMDl/MXtd9b3l0z4QyTKJwnWw
         HkLXg6x54/+dIlkkY0L8eZQZFyOLmSuEyePf8QrUsKCpo+rUHzkmwdl1Et+AdjXjpIgy
         ZOrcCkOXfg4mss29mb1L15b8oNP25/5vAZjUvKanLdBsD8a38ECCTixEDylDsDB8gSFx
         uB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Al9bVe7ZlBBHxflPN7dDbRiQZxeGn2j4XWyGYUriWq4=;
        b=lboZi4KkkMfB1mS2Ks0BOCa49GxLxJtPI81BiegyGAR44F9MeDP2mOmFWrv5uPj/E2
         O2pYga+zpyQqg1RmvnF5dgyVShPj75lX2Xsim4lvKdhiovooV7U7iKJVltpl+V0TIgjm
         KRLQ72vt8nDOSS1+jJweJMJlJ4AF9LZeOmzEegZIkO44x0+ypUcmfUSBfr1SnEsLykdj
         8VThYq98rwRCFGfIcq75DFqRGN31vyFWuLK0cb/qXkXBPYuAWhVpgjDMo/j0hf2g1lhd
         QQNqAkhFyeNW87v+kjazG2ixAMZpnBwYVxYz8uJuIyZzLynj2LTR+mE7Wt37ByOSPLqz
         oINw==
X-Gm-Message-State: AOAM531+p1fZSitgbOUDphLNChuSeXa+0taf/BQmIK2s4rb/6QIc5yoS
        ymlxgWjrx42bkyn/jM3Dtgr7cFZsvzL49xHNeB0g2A==
X-Google-Smtp-Source: ABdhPJzP8xGfPla++awyn1G27r3LXkIK3wvrijkd0Yt2tCqMYT1XZqk96h9xZY+z6BFU5GitM9gSj9v4Yy16fmVlvh4=
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr708127otl.237.1640138661156;
 Tue, 21 Dec 2021 18:04:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639696427.git.quic_vamslank@quicinc.com> <ff9abf953c274a1e34f59114642f67ecf02acb6f.1639696427.git.quic_vamslank@quicinc.com>
In-Reply-To: <ff9abf953c274a1e34f59114642f67ecf02acb6f.1639696427.git.quic_vamslank@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 22 Dec 2021 03:04:09 +0100
Message-ID: <CACRpkdYR2e3PgtzS5T69m9B4yEZ0wgAm=6HxOSpwwMz95nBBXg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: pinctrl: qcom: Add SDX65 pinctrl bindings
To:     quic_vamslank@quicinc.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        manivannan.sadhasivam@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 12:19 AM <quic_vamslank@quicinc.com> wrote:

> From: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
>
> Add device tree binding Documentation details for Qualcomm SDX65
> pinctrl driver.
>
> Signed-off-by: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

I applied this updated binding instead of the broken one
that I reverted a while back.

Yours,
Linus Walleij
