Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E25564CF3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 07:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiGDFgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 01:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGDFgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 01:36:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740405F8B;
        Sun,  3 Jul 2022 22:36:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1BF761481;
        Mon,  4 Jul 2022 05:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9BEC341CB;
        Mon,  4 Jul 2022 05:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656912989;
        bh=AWMVX+RQSTQTEGX1c33ORYkNFmnocumuLpJzoc6tgsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cmpRAt3YRyvIARLOi1wDwNvirn01XSmWvSZNv+nQg/PAdDCXVa5hVDUF55+7n/7bG
         JTnSOKFNJekGZgekZ1785kN/y8iLkjWf28Xg//Sfap8EfL4UFF4Gssurp07zZyw9tC
         rKO/aXE6XOZpMqTj3jWgdBCuAa6I5pkdEIDbLk3fDNslDqzx4NjkwkuBrMVepkOsK+
         ePDBb7u47LKIwqSJqD9EZv37BEqIul+aggurzAv7OIkPlO/qUq+eH6/UPPxOyni5nL
         7+BvwudXZoISgJTizVhCLhXfC1dDkPM1gJsv24kAI5IfNdsuS656Au+XXfCKhWtg1z
         1MFheJbsWkZqA==
Date:   Mon, 4 Jul 2022 11:06:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Subject: Re: [RESEND v5 2/2] ASoC: qcom: soundwire: Enable software clock
 gating requirement flag
Message-ID: <YsJ8WHgiybU0cQP/@matsya>
References: <1656659827-27450-1-git-send-email-quic_srivasam@quicinc.com>
 <1656659827-27450-3-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656659827-27450-3-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-07-22, 12:47, Srinivasa Rao Mandadapu wrote:
> Enable software clock gating flag in private data for SC7280
> based platforms, which are soundwire 1.6.0 version based.

why is this tagged ASoC... ???

I have fixed it up while applying

-- 
~Vinod
