Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0D54EAB28
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiC2KWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiC2KWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:22:19 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767D95F94
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:20:36 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.70.161])
        by gnuweeb.org (Postfix) with ESMTPSA id 2E6DF7E723;
        Tue, 29 Mar 2022 10:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648549236;
        bh=KvLfncTB+kd4Y/0TDTnUPpX4yenNIwZjb3BU/JLQSfw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CbwxvBZ5Mk07w0kCMxlVWWx9JF2qlvcOfv+q0Ao0rqKqUi4Y/qw4yIoUNnmeQ0jgO
         bZmOmM6Kqf/vySLG+YQ6rlV/Y6kW19txpvn/AgEJX0/waWastV1UtWa83e4TdHdO6y
         BwwLNV1rWSFwUPVuvI/J35TTxZB+mSYoEgM5g2WdI1wvXIINvlrr3P+hWjN9S0nxuY
         nA3hdYJKNMEd2wgIkp2pUBCSt29jIRLljCSYhPi8znh/Bi5DFvt+pWdehKfSO4VDPN
         O9uHlahj4YrjYg8VWKHcMJBEymQDDaKHrFDfikFyZ/cEFPWuEH+chawcbzQj3SBL16
         rFvra6lzbwJxA==
Message-ID: <2504aa03-e3cf-a120-44dc-af70ec7c9d5c@gnuweeb.org>
Date:   Tue, 29 Mar 2022 17:20:31 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/9] Add dynamic memory allocator support for nolibc
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>
Cc:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
References: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 5:17 PM, Ammar Faizi wrote:
> Hi,
> 
> This is a patchset v2 to add dynamic memory allocator support
> for nolibc after 2 RFCs, please review the changes carefully.

Sorry, forgot to replace === with --- in for each patch.
Should I resend?

-- 
Ammar Faizi
