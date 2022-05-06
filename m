Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C11C51D3A7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390283AbiEFIvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242702AbiEFIvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:51:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1172A580D7;
        Fri,  6 May 2022 01:47:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D828B83408;
        Fri,  6 May 2022 08:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426CEC385A8;
        Fri,  6 May 2022 08:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651826835;
        bh=+ufjvO7P96KYb2XbcCIj9uJ7p81LI1Ql3CZxkOp2IaU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Fvj9B9xwDSiPeqEcTecehkOah/pHPFo0wISr1GNyf7fNRbmQ8ren8viMRQBOVWYKH
         uza5c4k+QYCDlJz7Zk9jNMiz+aAp71dtHDBq48jJcmk6NGZ/shsA9k6ogJkhfm9DeP
         Vs2XUIW1UfQpsoflkv7RZb4IbfVT4Wbqew31JVOhvKWiMzgQSqkKUIqckbAC9mhhAL
         1W1lsrUVX0Dk1/f9abAk030teC/FIk4+G+oR1LeMrGRfPYeC9Z4lQCaSlwScXnqzjz
         djS9RfIn5OaKj7Z8fQ/WkDZqQ7cW4NLp9y4dYKiXrFENCk24KBh9x0+4OMYwqIZgfD
         lWe61DUP3XbVA==
Date:   Fri, 6 May 2022 10:47:11 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dongliang Mu <dzm91@hust.edu.cn>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: bigben: fix slab-out-of-bounds Write in
 bigben_probe
In-Reply-To: <20220506072425.1121900-1-dzm91@hust.edu.cn>
Message-ID: <nycvar.YFH.7.76.2205061046570.28985@cbobk.fhfr.pm>
References: <20220506072425.1121900-1-dzm91@hust.edu.cn>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 May 2022, Dongliang Mu wrote:

> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> There is a slab-out-of-bounds Write bug in hid-bigbenff driver.
> The problem is the driver assumes the device must have an input but
> some malicious devices violate this assumption.
> 
> Fix this by checking hid_device's input is non-empty before its usage.
> 
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>

Applied. thanks.

-- 
Jiri Kosina
SUSE Labs

