Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E75D5A0C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbiHYJ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240048AbiHYJ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:28:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7CBAA3FD;
        Thu, 25 Aug 2022 02:28:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EF4AB827DC;
        Thu, 25 Aug 2022 09:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C98C433C1;
        Thu, 25 Aug 2022 09:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661419734;
        bh=euspszcD5Bv35WXVNUON/0s8Nd1+hwZGTV6aiKSOsXw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=sZlXOBKClzM3z8J3OmF4Tp+yaX83B7P6DSF5VeRn6ZBjl+yP3KVFU5/HcCWEQzXy/
         9/ixYbC9BS/gwRtGtPrf1+kIpE1rnTR1CT1cPNSUeGdDSdHaig/6iqMVJKCvo13GWh
         Ra6/P2CxQKWUsc88ZQWOz4kMpx6XISYaq82ASWzY/+Pz9Ebv2TuwUbMgLBC9dgkPWq
         PYCOJMbQgV2a3wS/RmGq5PKWYdlwYjy9LAFqGa9dKB3s1l3b8R1rlL2vUAbz9kledW
         po8ceF69UuHE4yFOIe054N5kSj2SNbFcjI9uuI1MIF2U0dPYMHjZupPNmR9T8aGPCu
         S5OJU9drHAB1Q==
Date:   Thu, 25 Aug 2022 11:28:50 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: Kconfig: remove redundant "depends on HID" lines
In-Reply-To: <20220709015759.6396-1-rdunlap@infradead.org>
Message-ID: <nycvar.YFH.7.76.2208251128410.19850@cbobk.fhfr.pm>
References: <20220709015759.6396-1-rdunlap@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2022, Randy Dunlap wrote:

> Remove all occurrences of "depends on HID" that are inside the
> "if HID" / "endif" block since they are redundant.

Applied, thanks Randy.

-- 
Jiri Kosina
SUSE Labs

