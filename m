Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5955D510023
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351513AbiDZOQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351489AbiDZOQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:16:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F4A192AE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:13:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3DB3617A5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242E2C385A0;
        Tue, 26 Apr 2022 14:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650982410;
        bh=RofGvcu1ei9rfLGRCQtdIc30Yw2jgOKd/JjFNzj/g5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=si6Q5SneJV2OTU1qUBiJBtEGh9AEYsGEUdKrHTjYJfTVdiMXA1Cqf6HzXEcz3PKEF
         9V7nc4Nxgd1oFEQZNE2Upg8/8hv8j3FpWHkcSglM6GKAkNy3LsP00cWVHBRXwdCb7M
         F4fBJ0LgoYnZ7F495KngqaWBEcIpV4YEKSeO6jtY=
Date:   Tue, 26 Apr 2022 16:13:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, sboyd@kernel.org,
        rafael@kernel.org, johannes@sipsolutions.net, keescook@chromium.org
Subject: Re: [PATCH v3] devcoredump : Serialize devcd_del work
Message-ID: <Ymf+Brpl77kvN1I4@kroah.com>
References: <1650981343-11739-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650981343-11739-1-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 07:25:43PM +0530, Mukesh Ojha wrote:
> +	bool flg;

This is not the 1980's where we had a limited size for variable names
due to memory and compiler restrictions.

Please use vowels and descriptive names that identify what the variable
is for instantly.  "flg" is unknown.

greg k-h
