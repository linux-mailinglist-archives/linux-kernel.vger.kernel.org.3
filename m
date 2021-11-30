Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B17463EB4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 20:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239343AbhK3TjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 14:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbhK3TjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 14:39:05 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3A6C061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 11:35:44 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id nn15-20020a17090b38cf00b001ac7dd5d40cso2219453pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 11:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sWDyFUWdxQ2L44Dn9O1YprGmnD4i/gjKFy72LcInh24=;
        b=fmYdoJ+QfSpi5+zRZ4ATR/0W0w720kKBu4Xrp/ZsepzVY01HH5nbmE36LaxtPPBSip
         ysDFLwU929EgGOajUfGGDcOYhaq2k2HYXI7Z8KH173ntngRday6SvOTuqWWA+MNLcrCq
         Bgg4CLXvWsEaiu63OFjo/n8n+IrOoqRgHzSzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sWDyFUWdxQ2L44Dn9O1YprGmnD4i/gjKFy72LcInh24=;
        b=vxP82EaEv7ZwPPOB9jRDw/u7o5NPS/cQ35qPCGV5bm3NgojRtsWOko4i7H8jvb3deQ
         ethJSH8MxCxkUr75tvFkEFfV94hJ1Hax0goClzRZDoHFt6BucZdurCjkpBl3PDbDt5Wb
         pPbl7Z6py4PdMVyq/jDVibZvADGzZrMxgO1bXOXUOKNhw+qg5Nke/XaEzHoX5WC6msxb
         NWx5ng+b7Ds5klBEdqRivgjHVEhBIhfOTTdGYJBJwHYoEZuys2U0Oa0bDHGOfkxTezN2
         OhtC7B6Lk3AGyTayfk7vYNq51EI3SR4gzHtpn7CFxxlYs+mZv/Yl7lWk8QU97Z4bqmMj
         efEg==
X-Gm-Message-State: AOAM5310mCNgwVX8IpjaXQfPZjOTTq0iBHB/DGULHnO7XtLPlB16paXL
        jb4qa9Vw7MI5EvccJDAYP95vLw==
X-Google-Smtp-Source: ABdhPJxlig6ZOOMb1RNyt32Dkd0PmMZkCbFfytvvQixTbiIqmc/Zam9IdbX+O+gw0FueolJYoaHZJQ==
X-Received: by 2002:a17:902:748c:b0:141:c45e:c612 with SMTP id h12-20020a170902748c00b00141c45ec612mr1197720pll.73.1638300943617;
        Tue, 30 Nov 2021 11:35:43 -0800 (PST)
Received: from localhost ([2620:15c:202:201:ecc:102f:1eec:93da])
        by smtp.gmail.com with UTF8SMTPSA id g1sm7763102pgm.23.2021.11.30.11.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 11:35:43 -0800 (PST)
Date:   Tue, 30 Nov 2021 11:35:42 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        kgodara@codeaurora.org
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sc7280: Define EC and H1 nodes
 for IDP/CRD
Message-ID: <YaZ9Dt98JJ5UqW6K@google.com>
References: <1638185497-26477-1-git-send-email-quic_rjendra@quicinc.com>
 <1638185497-26477-4-git-send-email-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1638185497-26477-4-git-send-email-quic_rjendra@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 05:01:36PM +0530, Rajendra Nayak wrote:
> From: Kshitiz Godara <kgodara@codeaurora.org>
> 
> The IDP2 and CRD boards share the EC and H1 parts, so define
> all related device nodes into a common file and include them
> in the idp2 and crd dts files to avoid duplication.
> 
> Signed-off-by: Kshitiz Godara <kgodara@codeaurora.org>
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
