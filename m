Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4FF4DD99A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbiCRMUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbiCRMUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:20:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5182DF14A;
        Fri, 18 Mar 2022 05:18:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCF83B8220D;
        Fri, 18 Mar 2022 12:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B1BC340E8;
        Fri, 18 Mar 2022 12:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647605931;
        bh=ym4815U2ifya4E4l4O1IL4CK/CxYX1I2gdaTHOwIDUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zTay6a4KILQtZqPZzAs+pcSpVAetScE7OHwIg4k1UvrWwAHFtUbkK2XAqRKmjuRPE
         JPsBKpucXCKdGr3GlGl1seD7pi3fka7tRWZ1EpZSQvCL27LYmFmWqxv2ET9RNGNCD/
         7FvJsvXMIsH+6G8RZ/JneYtNiq1ujjQzaY60tff8=
Date:   Fri, 18 Mar 2022 13:00:34 +0100
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
Subject: Re: [PATCH v2 1/3] usb: xhci: refactor quirks and plat private data
Message-ID: <YjR0YkIq9F3mBia5@kroah.com>
References: <1646130507-26796-1-git-send-email-quic_c_sanm@quicinc.com>
 <1646130507-26796-2-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646130507-26796-2-git-send-email-quic_c_sanm@quicinc.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 03:58:25PM +0530, Sandeep Maheswaram wrote:
> From: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> 
> This refactoring allows drivers like dwc3 host glue driver to
> specify their xhci quirks.

This text does not describe what you are doing here at all so I have no
idea how to review this :(

