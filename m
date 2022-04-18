Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE85E505C31
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345820AbiDRQGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiDRQF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:05:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5876A12747
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:03:20 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ll10so13334418pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TweijuCzv8x4HVI+hbm7Bve8ZQCsolV5RsSU3xzQFgI=;
        b=SOcYH4m3zA6LHy6uJrNty9qBBBB+PiRPcmjo+na7oS2QUPnVzmdjyxsnwVJd75gFNA
         vlbvPmaEFQ6aKwQC2oNIOPp6Pi90BaektDQhlubZJAODoA4h0TRlAfgENe7bnNbnfQFZ
         P2DRvvZCGuTDw6N3QFJpEHGlB0ba8Gt3cpiI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TweijuCzv8x4HVI+hbm7Bve8ZQCsolV5RsSU3xzQFgI=;
        b=cQ4b4B7yspfC9APpBH+WI0WtkEIA8gLL/VI7sXW9x+ELG0L56Hf6HkPOLNeXyyhfB/
         taXUZjfMo3nfDl9uGZF1q483Gsh5eAHIxHyKg5b4YxyauWORO36CfONtaoCJbFnZyLqf
         toBWr1orsFFR01jVr0WPor7/kPAyrQvw1iexUot46Iv/saLX/CPJS9eA+A8r1jObUqoR
         rBdeSBYyv9IlHBQM4v0clSZwTQy56XsClaa4VE0nDtrYo0ByVgXMCAluMXIpe68U1Krg
         aWr/151RzIkr+2Z/fe4aHMMqm7huJfVwhBa4SH3Cn0vOEeVj1EqIkpHSkoAT2mbRaKvb
         r9Sg==
X-Gm-Message-State: AOAM5306Zsz5dbYMKoSva8WRBzJDouK21TFzpnXw5rssVzQxdpFNtFi9
        VJpzo+gYRMPUEqTrSGi2GsrWbg==
X-Google-Smtp-Source: ABdhPJwUvSC2RU6pGD6+bp9qphTlXteDNwG3QvNqUYrTHnJx5LLdb3YaztDT0Jes8w2E+AXJjmmPvw==
X-Received: by 2002:a17:903:2d0:b0:14d:8a8d:cb1 with SMTP id s16-20020a17090302d000b0014d8a8d0cb1mr11245314plk.50.1650297799689;
        Mon, 18 Apr 2022 09:03:19 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6b32:a0a5:ec32:c287])
        by smtp.gmail.com with UTF8SMTPSA id t63-20020a625f42000000b0050a7eaff8c9sm3493826pfb.189.2022.04.18.09.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 09:03:19 -0700 (PDT)
Date:   Mon, 18 Apr 2022 09:03:17 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v8 1/4] arm64: dts: qcom: sc7280: Add nodes for soundwire
 and va tx rx digital macro codecs
Message-ID: <Yl2LxeYmNeLth77M@google.com>
References: <1650291252-30398-1-git-send-email-quic_srivasam@quicinc.com>
 <1650291252-30398-2-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650291252-30398-2-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 07:44:09PM +0530, Srinivasa Rao Mandadapu wrote:
> SC7280 has VA, TX and RX macros with SoundWire Controllers to attach with
> external codecs using soundwire masters. Add these nodes for sc7280 based
> platforms audio use case.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
