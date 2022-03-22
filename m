Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D374E3757
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbiCVDWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiCVDWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:22:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A156E13CC0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:20:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F0A0611FC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266EBC340E8;
        Tue, 22 Mar 2022 03:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647919248;
        bh=Wy1czrcvdbkgA1Vf4P4jKaT8H77cJBQr5T3RcbSkKyY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=b64Taf3Exr0MNSDEzE1LesUmCgs1Nm0ZvVe6T2CopwHi6cgwJF2r3MVYoQrfg89/d
         renmiAsNnDUev/xZxf/cj2/SkaOIa+NJkxhJIzkWLrpasbpTL62GPPcT9wq9zEsekk
         CIjJKt9Xqy2L4S74u4E67/TFOtzMHVwOP67U93cQYALWP50f66EieHaH1yFm//U57Q
         1iaoHeigH1pq38EtuEbKrHVZNFd3daQAVEHaS2RjunsWRdQLPiloIGRF69wXmC6EUk
         9DqTOJzq3g9cL+woahBYXGFeI+1A/yj4hZ80Ar6fybrbUCoBO2sCbq6vO8vdEzBhAM
         CHIWGu1hH6HHQ==
Message-ID: <626158d2-2b8a-028e-2489-732cc7805300@kernel.org>
Date:   Mon, 21 Mar 2022 22:20:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] firmware: stratix10-rsu: extend RSU driver to get DCMF
 status
Content-Language: en-US
To:     kah.jing.lee@intel.com
Cc:     linux-kernel@vger.kernel.org, radu.bacrau@intel.com,
        tien.sung.ang@intel.com
References: <238c6460-16a2-c630-9027-3fe31d0d59c5@kernel.org>
 <20220322094429.375237-1-kah.jing.lee@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220322094429.375237-1-kah.jing.lee@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/22 04:44, kah.jing.lee@intel.com wrote:
> 
> Sorry folks. Made a mistake, miss spacing error in the checkpatch in header file.
> Will be more careful on the next upstream.
> 
> Hi Dinh,
> Do I continue with this v2 subject or re-send with another v3 patch subject ?
> This version has the correct format check.
> 
> Thanks.
> KJ
> 

Just send a v3:
