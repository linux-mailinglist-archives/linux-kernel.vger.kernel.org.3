Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAAC509A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386606AbiDUIW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381397AbiDUIWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:22:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3833B5FB4;
        Thu, 21 Apr 2022 01:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE76FB82145;
        Thu, 21 Apr 2022 08:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C228C385A1;
        Thu, 21 Apr 2022 08:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650529170;
        bh=2CZwHx4HVzYufFl2v4wil52kbsl+K8+mJxMxiPbGbnw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=HKKe0iLMEMOLR+KQriHplJvVqeBlCUMTSAYujqEQnk+q2L424QSiZW8J060T3QnLR
         yYk8qVmsnet32d52/RTpV15I2F0fZoMpnPByWjaq5Ak3exr5Yp3P8TI1qacnWmCwjI
         BuZLfmiEQZN3gfCFauHZ+HniAcQeQhcCFC9qHkKoZcfZNWMlGbNaxbLN7dHpoTK3T+
         nAJd3ZlcQ8x0tIROC7vija6H6KYef9BXxlBKVr5T0J2ZVYTlIWF7Lrj1ew3on8bmG6
         qZz6o/+cYTl/DhVFUXAiOdqqmDYmACmRaXcjQIpgnOdaEUSN0LacWalp+fKYKtC3vj
         34oFE6nlT2pmg==
Date:   Thu, 21 Apr 2022 10:19:26 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Tom Rix <trix@redhat.com>
cc:     basavaraj.natikar@amd.com, benjamin.tissoires@redhat.com,
        nehal-bakulchandra.shah@amd.com, Shyam-sundar.S-k@amd.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: amd_sfh: change global variables to static
In-Reply-To: <20220420142244.556429-1-trix@redhat.com>
Message-ID: <nycvar.YFH.7.76.2204211019190.30217@cbobk.fhfr.pm>
References: <20220420142244.556429-1-trix@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022, Tom Rix wrote:

> Smatch reports this representative issue
> amd_sfh_hid_report_desc.h:182:10: warning: symbol 'gyro3_report_descriptor' was not declared. Should it be static?
> Similar issues for comp3_report_descriptor and als_report_descriptor.
> 
> Global variables should not be defined in header files.
> This only works because amd_sfh_hid_report_desc.h in only included by
> amd_sfh_hid_desc.c so change the storage-class specifiers to static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied, thanks Tom.

-- 
Jiri Kosina
SUSE Labs

