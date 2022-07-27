Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029D3582388
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiG0Jz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiG0JzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:55:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4E1CF2;
        Wed, 27 Jul 2022 02:55:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AD00617C3;
        Wed, 27 Jul 2022 09:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098D7C433C1;
        Wed, 27 Jul 2022 09:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658915711;
        bh=bhTSXCt1ePSDDeplP4J42KNtAtIFCBpuBXvtfYursXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zPl1dMeO4/qrZZaTMLX020EHP5y6fOJ3ce8u3NVr77etzG1dgVWVvGRn9tTHa3dZe
         wr9IW2tBG1vu4pBrqj90rObr/YCLQAuMiWijQqFX6dHYKlwduQSZd6mCJfNHLChGv+
         4PtbJeTw7UCtjLsFi112VIvSYqLv634p7GN3GvCk=
Date:   Wed, 27 Jul 2022 11:55:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pratham Pratap <quic_ppratap@quicinc.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: qcom: Defer dwc3-qcom probe if dwc3 isn't
 probed properly
Message-ID: <YuELfGQv8lbftnV/@kroah.com>
References: <1657810516-31143-1-git-send-email-quic_kriskura@quicinc.com>
 <YtAv8R7QlTZCjvRO@kroah.com>
 <YtA78UfeibaQW4pf@google.com>
 <9f8551be-4848-1f68-fe55-2c6108fa2f67@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f8551be-4848-1f68-fe55-2c6108fa2f67@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 03:03:01PM +0530, Pratham Pratap wrote:

<snip>

Please note that html email is not allowed on kernel mailing lists and
the messages are thrown away, so no one can see them :(

Please fix your email client so that you can participate in kernel
development.

thanks,

greg k-h
