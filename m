Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD13570D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiGKWe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGKWeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:34:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710842ED65
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2281AB815FA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 22:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADCDC3411C;
        Mon, 11 Jul 2022 22:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657578860;
        bh=RUmLfntR7JwVUavbkVa2QfanpevGIfKVMLsU8OhkF/8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tszgm6i1O+j4kHAGPXHVeuXNrlKUuWjTe1KPkOu5H5hOUEiH9WvpTXjoQaQtLInjY
         +QO+6yJ9TR4TPKYcw1cCNjPNxWtae/Oj5LPvFloNQlpVV5/DfhOU+PWF4RHXPQJ1G7
         QFnjmjKqJik4753cjLHx2Q8p2kH0GimHu0cCSaON6hBw/OLIPYcxCxCZg3sGSSrHZ3
         byGlRxDQ2hVgdxaYrGFwTVKhOIAPfVvki3ZDdKb+E+NSkycPX/DH2jabzuzBLABNLp
         3yz6Ia2QTElrbLiIcEnESEGRhauErHn0zKRHtFLK31CDbFXDBTMoJUvq6O6d3Z8sRz
         eGROzLc5z1bQQ==
Message-ID: <01ce6a13-54c8-6d7e-64d3-63b423d9b602@kernel.org>
Date:   Mon, 11 Jul 2022 17:34:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/2] extend svc and rsu drivers for new RSU DCMF status
 feature
Content-Language: en-US
To:     kah.jing.lee@intel.com
Cc:     linux-kernel@vger.kernel.org, radu.bacrau@intel.com,
        tien.sung.ang@intel.com, karnan.shanmugam@intel.com
References: <20220331154237.4158001-1-kah.jing.lee@intel.com>
 <20220706102329.1643576-1-kah.jing.lee@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220706102329.1643576-1-kah.jing.lee@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/6/22 05:23, kah.jing.lee@intel.com wrote:
> From: Kah Jing Lee <kah.jing.lee@intel.com>
> 
> Hi Dinh,
> Any feedback on these two patches?
> 

I got done with my review and just sent it to Greg KH.

Dinh
