Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D2F4DD99F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiCRMUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236183AbiCRMUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:20:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AAE1EC601;
        Fri, 18 Mar 2022 05:19:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5533618B3;
        Fri, 18 Mar 2022 12:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87544C340E8;
        Fri, 18 Mar 2022 12:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647605939;
        bh=H8pxo4tsDjKXFt3tUygCmfSFmNQBhKEe3tgt/Zdkk0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S/Vh8yy5XhXcR8vvsLdF8f+/uNV7unzY/E0QW82g+2nzWCS1TmusJKrPfL829z6Oo
         Ty6hvy2SGTEXnjy6u7vOI/VcdOY6B3wzY1cWpM4sZemoeFNnHf4bF4AfeIIPrvXq76
         TWmzxkFbPGn4hFFhs/PW/yzD902vrnI5uaru/CfM=
Date:   Fri, 18 Mar 2022 13:01:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com
Subject: Re: [PATCH v2 3/3] usb: dwc: host: add xhci_plat_priv quirk
 XHCI_SKIP_PHY_INIT
Message-ID: <YjR0pXtB5pfnqHu1@kroah.com>
References: <1646130507-26796-1-git-send-email-quic_c_sanm@quicinc.com>
 <1646130507-26796-4-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646130507-26796-4-git-send-email-quic_c_sanm@quicinc.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 03:58:27PM +0530, Sandeep Maheswaram wrote:
> dwc3 manages PHY by own DRD driver, so skip the management by
> HCD core.
> During runtime suspend phy was not getting suspend because
> runtime_usage value is 2.

I do not understand this last sentence, sorry.  Try rewriting this a bit
to explain what is going on here.

thanks,

greg k-h
