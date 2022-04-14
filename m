Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBDF501EB4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347047AbiDNWvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiDNWvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:51:35 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F01C6F00
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:49:09 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id j17so6050098pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZpnIt1SvBZYeiyTQzg8zajT9zTmRqMyyhzIh67HnITc=;
        b=FIY3CPPiipmHcw8nqEuMh5Z1JOvA3XPw1nf+FgJfGYOwP4czCvczPGH6oWfAc/hpPG
         VNIbMhqj6H/OFrlNQ7zJIOYQBPhzN4f3eLgik4ub5Q+hQc3/XNPe/B7oWqtTeUWPdoIs
         Z0unZhGh0H99MmssZWzt+N5ZzgJTCVlrbMVis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZpnIt1SvBZYeiyTQzg8zajT9zTmRqMyyhzIh67HnITc=;
        b=wB+SZSadHn9Y2aNiPM+oxclLzeh3oeNQaI5R9NIaHbrxE+jqw+K/9XHhluoAx/ipvE
         kB0LzV1BeSEiYGh4CS/p3ZtRwqEMpqYZFk2na22Qw0S6gbM5oP0Vp4iikMKcsfaOkgP8
         unyCKbG3TGUoCxh6mngE6FIZtwk27U8JSNUqpS+bM9kYexen2XFJYXvTR6QvRW/8az5b
         Udbrlv1MjSC6LVveEaR/SQUkC/ZnLMK3uZRT9KTLQf+et0pXVrcDc/xbbVXt7urA/ZDc
         tk/4cKrdKSWzgI3F0YSKNB94sXkXFK1ICrHj02brfe69KWawK1vLYcVkTIRv1Q20gMxT
         S7lA==
X-Gm-Message-State: AOAM530L/yFvuwA/L09pL5XazGb8SQ222LxNGueGfyjYrMUmyLR2+Zcu
        0jpNMc6lYKa9Eiv6qTOShaT+hA==
X-Google-Smtp-Source: ABdhPJwYfOsHO2BI/jF1Y04THNwTg0wnx21olhpSd2to0D3A4ipcVh32WfvDpCFI6hkvVF+tyaVrvA==
X-Received: by 2002:a63:2b0b:0:b0:39d:890a:ab68 with SMTP id r11-20020a632b0b000000b0039d890aab68mr3964291pgr.247.1649976548592;
        Thu, 14 Apr 2022 15:49:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7064:6d7:29ae:2a8c])
        by smtp.gmail.com with UTF8SMTPSA id h21-20020a056a001a5500b004fb71896e49sm864489pfv.25.2022.04.14.15.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 15:49:08 -0700 (PDT)
Date:   Thu, 14 Apr 2022 15:49:06 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v10 2/2] arm64: dts: qcom: sc7280: add lpass lpi pin
 controller node
Message-ID: <Ylik4jdqFyxIZtBv@google.com>
References: <1649944827-6455-1-git-send-email-quic_srivasam@quicinc.com>
 <1649944827-6455-3-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649944827-6455-3-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 07:30:27PM +0530, Srinivasa Rao Mandadapu wrote:
> Add LPASS LPI pinctrl node required for Audio functionality on sc7280
> based platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
