Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEF6513F89
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 02:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352760AbiD2Adm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 20:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348636AbiD2Adi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 20:33:38 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657CF2FFEB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 17:30:20 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id bd19-20020a17090b0b9300b001d98af6dcd1so9116677pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 17:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jmljM4FICPNK95l/noM5ZqyzaP70WYeuCPsRfukH3zY=;
        b=HL/MPvnZa4kAs14Bpx2qes8HJc/78pX0p3ekNAtGu9o1l5XhdX4BW/Vu+CP/yaoyg9
         qVA8SFH+sCtqAdq60kc0UpEyxr4j1sEM+r3+4FpWYV4Efaj9SaAW0Jqd0eYUhs++WnNU
         aM/7YPvyXUgqk5kns1OGlMQr4gEv+SOv+Nj2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jmljM4FICPNK95l/noM5ZqyzaP70WYeuCPsRfukH3zY=;
        b=jU275h7msdMEzqGW/ZcIp0FcSuTEy57j7TfSYM5hjfCMGuQHY0TfoJw5BXAgyPlPn6
         vETjIUi4gk+lxGnp5fvoMNWbZc0cNo/mcmZX2ZMjmOP5bT5AsGWu2oPK7+ccKEGOoHSC
         heH354Z/fAiv39p4mtmB49uKnYBfMdsz2yaVTzsFS4sHYLI4Ke7ZZ6nrYn7ZxMwI+cTf
         baat6q8WtEA6E89tR6J9vbT+qZM3BaDl1fzPZzsgDEFSi9tei8FfkGhwQYzIV6O3ePRB
         Y1KpEgNUuhFrmD14rZ68wzyXkynqBoGoYMgil9g7fTCXykyXBPTeIgDoRp61Kc65EmVv
         jy4g==
X-Gm-Message-State: AOAM530u7dN3rXZl29eocBBFPsw+c/o4MZhrL9GIRrVSDjbmZvOKfHa1
        ZsBmND+qpaYz9AInl2pgZE/nTQ==
X-Google-Smtp-Source: ABdhPJwxcuz8buO11jDSkmrug/EvrwKpN67kCAVXPYAtg1DJlGtv1dxcrFgy/3qS1eexgynXqygYSQ==
X-Received: by 2002:a17:902:da85:b0:15d:3a9a:aad1 with SMTP id j5-20020a170902da8500b0015d3a9aaad1mr14838800plx.113.1651192219978;
        Thu, 28 Apr 2022 17:30:19 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7d14:5f45:9377:9b6a])
        by smtp.gmail.com with UTF8SMTPSA id x4-20020a628604000000b0050d2ff56603sm945978pfd.60.2022.04.28.17.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 17:30:19 -0700 (PDT)
Date:   Thu, 28 Apr 2022 17:30:18 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Only include sc7180.dtsi in
 sc7180-trogdor.dtsi
Message-ID: <YmsxmjykRaykun32@google.com>
References: <20220427020339.360855-1-swboyd@chromium.org>
 <20220427020339.360855-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220427020339.360855-4-swboyd@chromium.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 07:03:39PM -0700, Stephen Boyd wrote:
> The SoC is always present on sc7180-trogdor.dtsi and thus we should
> include it in the "generic" dtsi file for trogdor. Previously we had
> removed it from there because we had to do the spi6/spi0 swizzle, so
> each trogdor variant board had to include sc7180.dtsi and then
> sc7180-trogdor.dtsi so that the latter dtsi file could modify the right
> spi bus for EC and H1 properties that are common to all trogdor boards.
> 
> Now that we're done with that we can replace sc7180.dtsi includes with
> sc7180-trogdor.dtsi and include sc7180.dtsi in sc7180-trogdor.dtsi as
> was originally intended. We still need to include sc7180-trogdor.dtsi
> before the bridge dtsi files though because those rely on the panel
> label.
> 
> Cc: "Joseph S. Barrera III" <joebar@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
