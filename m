Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D402A470C65
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243435AbhLJVVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:21:31 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:42596 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237428AbhLJVVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:21:30 -0500
Received: by mail-oi1-f174.google.com with SMTP id n66so14914699oia.9;
        Fri, 10 Dec 2021 13:17:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q0bPerVgAjvBuE/PcLA6saZylIAAwjAD+Ufdm6YbSp0=;
        b=X24PQiWhvN2BHsiG+gMb5z4ihQ3QemkKzEycQBQAbv+XYmL/2xY1X6pKpUqXJ1hNu4
         DwiRECEtgAJoge44aPu3DMxpZmEmIQ6ndA1y+F5yU3ou7NDMRemg7u6IVG2uvxFufbNg
         SkyGeJ8sZmsciVelc+xdPACjVbyApryowRRi2tk/7PXqTEGFrrAVhDPVkuol6WmuRUnz
         LMwml+0eRKXcrJKqOSB/7jzL8Wu351dtAuH04ROLwX3Nr1rtx+XTAr6HSS+wO/T1LfFu
         nvHMch+DL1k2z/MPzhV9oxf94eICeX1vdRxEy1M2/S1ej5tuiIOlXhKma9UcoVqO7cok
         hQYg==
X-Gm-Message-State: AOAM5337hvzpWa71uJPiiAWBUzvIk2A9xxMHCB16tbhDgTVQ0yxRBvKa
        BqAMvNAQhJabgxq+AWR+Ag==
X-Google-Smtp-Source: ABdhPJz2u2x7Bu7qvex+Re/WcUxmkShg6AZtjjoYaPNtDL5dTDsqyPg1NFLveQRPAb4o7r8aYE602g==
X-Received: by 2002:a05:6808:3c6:: with SMTP id o6mr14779782oie.145.1639171074705;
        Fri, 10 Dec 2021 13:17:54 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r26sm699244otn.15.2021.12.10.13.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 13:17:54 -0800 (PST)
Received: (nullmailer pid 1914880 invoked by uid 1000);
        Fri, 10 Dec 2021 21:17:52 -0000
Date:   Fri, 10 Dec 2021 15:17:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v5 2/5] dt-bindings: pinctrl: qcom: Add sc7280 lpass lpi
 pinctrl bindings
Message-ID: <YbPEAAeH69Q93Wm9@robh.at.kernel.org>
References: <1638891339-21806-1-git-send-email-quic_srivasam@quicinc.com>
 <1638891339-21806-3-git-send-email-quic_srivasam@quicinc.com>
 <7ae29aa1-34da-c362-5712-4b787474d7f2@linaro.org>
 <bde0c8b0-7244-1bd1-84b6-8efab4f01fa2@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bde0c8b0-7244-1bd1-84b6-8efab4f01fa2@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 03:41:25PM +0530, Srinivasa Rao Mandadapu wrote:
> 
> On 12/8/2021 2:54 PM, Srinivas Kandagatla wrote:
> Thanks froYour time Srini!!!
> > 
> > On 07/12/2021 15:35, Srinivasa Rao Mandadapu wrote:
> > > Add device tree binding Documentation details for Qualcomm SC7280
> > > LPASS LPI pinctrl driver.
> > > 
> > > Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> > > Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> > > Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> > > ---
> > 
> > 
> > I remember in my previous review that I requested you to use git mv for
> > renaming this
> Yes. Created patch with "git mv" and commit. Not sure why diff is not as
> expected.

The 'git mv' is not what matters. You need the -M option for 
git-format-patch/send-email. There's a config option you can enable that 
by default.

Rob
