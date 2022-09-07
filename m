Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DEF5B068C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiIGO2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiIGO20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:28:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C02D7C1FE;
        Wed,  7 Sep 2022 07:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8CA361929;
        Wed,  7 Sep 2022 14:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4A2C433C1;
        Wed,  7 Sep 2022 14:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662560854;
        bh=wQM3XmiJVGNYB27p9u4rk3PQB4NNJl9+uK35wSt/t/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MoHExXsQRXAL7Y18ICWTPPIUwbO4fJpgt+gdlafpzYsliMXYoc95TJZeYi7rOFDH5
         g7hlvkzWBZyQF+NTlZz8s/69MuToTRsx72Y0Jq2SPwtSEjWx2FTv/9K50MYTgJGY5U
         Nvh6w5hjiRpbbPA+s5EAYF9S7ALInyAawZswUIFQ=
Date:   Wed, 7 Sep 2022 16:27:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     balbi@kernel.org, Thinh.Nguyen@synopsys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_jackp@quicinc.com
Subject: Re: [PATCH v8 0/5] Fix controller halt and endxfer timeout issues
Message-ID: <YxiqU9Rx74ayIl59@kroah.com>
References: <20220901193625.8727-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901193625.8727-1-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 12:36:20PM -0700, Wesley Cheng wrote:
> Changes in v8:
> - Remove stub for dwc3_remove_requests() as if DWC3 host only is enabled
> then ep0 isn't event compiled.

This only applied with manual override of some fuzz in patch 2/5, which
is odd.  You should check that it all applied correctly to my tree
please.

thanks,

greg k-h
