Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4852854EE7B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 02:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379423AbiFQAcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 20:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiFQAcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 20:32:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5BE101F7;
        Thu, 16 Jun 2022 17:32:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC23BB82678;
        Fri, 17 Jun 2022 00:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8E7C34114;
        Fri, 17 Jun 2022 00:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655425964;
        bh=ufmvqRGgHUvV6toZbYhN2qqM/1cyhHchPSmePII2uTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b65mvLcJfjJYO1Qf8hvyQeeqpDuV0a1fCijLoZbnHyWytw/+sgh0oAEFrS2BJtNd6
         lPeiga4R16AJcaUASexP39UwV/brsN/lt/dmsTcbQFRH/JSj+3Gck97Ti9MTCFzVUJ
         OPLmNKI3UQkm5jSUMfP7f5Vla9SbSnbQOfCDWYnGkM21xkO8h1U6mtmr1y18tzxEz5
         YgFZB0Kula+SO2TWYZ0pmS+rAstFYGtJWfNH8mQwQqJNNqnxCP/hdOd27VCCOLx+mP
         7VCSw2A0RXW30WS84D/xmUQzrSF5b8CaSFdoAfjmNvdJ/ntuCeMu5h6rjZ2XjGzrZG
         3eqrM5bNxqk1w==
Date:   Thu, 16 Jun 2022 17:32:44 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com
Subject: Re: [v9 0/3] Add QCOM SNPS PHY overriding params support
Message-ID: <YqvLrN+ZgC9QRbKE@matsya>
References: <1655095653-27892-1-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655095653-27892-1-git-send-email-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-06-22, 10:17, Krishna Kurapati wrote:
> Added support for overriding tuning parameters in QCOM SNPS PHY
> from device tree. This parameter tuning is required to tune the
> hs signal on dp/dm lines for electrical compliance to be successful.

Why is [PATCH....] not appearing in title (hint dont touch these
manually, use -v 9 in git format-patch to generate...

-- 
~Vinod
