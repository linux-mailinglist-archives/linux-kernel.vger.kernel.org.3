Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DB54D1487
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345709AbiCHKRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345627AbiCHKRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:17:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51563FD8F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:16:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1CE37CE1389
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E77C340EF;
        Tue,  8 Mar 2022 10:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646734572;
        bh=5PRdAeQUtYXT169fiOt10pRLXqanDooFjKN+Av0OCjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nMFSz7CvbWIgO2EzvfUgjkOB1DpMcOjLHZPuDNX5/QXn7JtcvT0SexZlCaCg2dzFy
         K2kN9C5SrHcNqL78WoH+QoHgI2A3s1ILqAw1C3MMcePt6bOh2Skm4xU+t5GgFAR4Qb
         YQooCHq+CycXItE1OpMEJm/X5301ZCyP5wztWTdY=
Date:   Tue, 8 Mar 2022 11:16:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     butt3rflyh4ck <butterflyhuangxx@gmail.com>
Cc:     fei1.li@intel.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virt: acrn: fix a memory leak in acrn_dev_ioctl()
Message-ID: <Yics6JbQljlQXRED@kroah.com>
References: <20220308092047.1008409-1-butterflyhuangxx@gmail.com>
 <YicoOC+WZhNLq+pX@kroah.com>
 <CAFcO6XMy+rT_cnw2Q7Jzg=byKWQ8tcVU+8ZBCCfTD1-JNy7oLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFcO6XMy+rT_cnw2Q7Jzg=byKWQ8tcVU+8ZBCCfTD1-JNy7oLw@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 06:14:31PM +0800, butt3rflyh4ck wrote:
> No, not yet. I just code audit.

Please test things like this so that we know it actually is correct.

thanks,

greg k-h
