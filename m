Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49074AC735
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240838AbiBGRXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377080AbiBGRNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:13:19 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6592C0401D8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 09:13:17 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id v74so14093164pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 09:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DzeP33bVe/PRU7l8u7/ekAKVRkuaC91XduTpV1y5u6w=;
        b=fPGGV4+OqfBLxhXgKlBk8GEqB/OZwotFkK2VUylFNXnzzoy5k7PKvKS/VII80jgz2x
         cRWUvL8sVKacsUb96Hf2u9AzOSzpy4joW1TerxQfRN7cXU5HS+a4DMdiqRCpeAGZgpTS
         bwcuIoPZbpT6NZqgWYXJHRpUPuvZ4z2HqFn4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DzeP33bVe/PRU7l8u7/ekAKVRkuaC91XduTpV1y5u6w=;
        b=Vf44G4+8sk2OL1kEtYjWG4qcPLJQcan1pLPjaAUjcKreBCxj5Y6fStvnC9eeh31qS/
         37PNTZMAtvi/blL73sKdv8h5vO4HMOIHlI3lqKsp4RYlaPK64RhsU6htqQPRHfTM9Cex
         h1L66IEsWcCYDuaFtkwTuZE0pOWsaSr+VcQuV0Dvl/YWxB+vwC6ECkYrd5ni2iuEIRZq
         BMQ8phrQHzdDxZSYifDoAl+7Q49JLJJuv5XilnXXR/qFNW4x9Z5p4k34MEH5Tjzs5kHr
         j5p8coRLt9qZNFTD2Ri+5JGJ1jatKuFVGsYplY7xiJH30Ny3N9wjEhBs+TAawWOE5jXo
         vHug==
X-Gm-Message-State: AOAM532HGSImYEZyyk12+e/0DbLfspjt/+oEa5XOo5PIfETSD0UYVUTi
        blY/XYFysQKvQc02r66RBUkdiQ==
X-Google-Smtp-Source: ABdhPJzcsEZUqhK8vVVbURSYFjIx0GewfFVvnIgrF3hcReRYwiUJF+QzYtK2SQJb856KCk4saoJebg==
X-Received: by 2002:a63:5a65:: with SMTP id k37mr285365pgm.431.1644253997205;
        Mon, 07 Feb 2022 09:13:17 -0800 (PST)
Received: from localhost ([2620:15c:202:201:21ed:2162:c25b:6bf7])
        by smtp.gmail.com with UTF8SMTPSA id 12sm9010815pgb.71.2022.02.07.09.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 09:13:16 -0800 (PST)
Date:   Mon, 7 Feb 2022 09:13:14 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sai Teja Aluvala <quic_saluvala@quicinc.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        quic_hemantg@quicinc.com, linux-arm-msm@vger.kernel.org,
        quic_bgodavar@quicinc.com, quic_rjliao@quicinc.com,
        quic_hbandi@quicinc.com, abhishekpandit@chromium.org,
        mcchou@chromium.org
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Add bluetooth node on
 SC7280 crd board
Message-ID: <YgFTKid5hOCmSJHh@google.com>
References: <1644207878-19839-1-git-send-email-quic_saluvala@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1644207878-19839-1-git-send-email-quic_saluvala@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 09:54:38AM +0530, Sai Teja Aluvala wrote:

> Subject: arm64: dts: qcom: sc7280: Add bluetooth node on SC7280 crd board
>
> Add Bluetooth SoC WCN6750 node for SC7280 crd board

That doesn't describe accurately what this patch does. The CRD already
has a Bluetooth node - from including sc7280-idp.dtsi - what this patch
does is setting the vddio supply for Bluetooth on the CRD.
