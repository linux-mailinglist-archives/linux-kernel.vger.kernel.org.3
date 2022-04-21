Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A6A50ABFE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442572AbiDUXge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243601AbiDUXgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:36:32 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6043FBCA;
        Thu, 21 Apr 2022 16:33:39 -0700 (PDT)
Received: from host86-155-180-61.range86-155.btcentralplus.com ([86.155.180.61] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1nhgIs-0004mn-6l;
        Fri, 22 Apr 2022 00:33:38 +0100
Message-ID: <4cabddcc-c83c-483d-89db-996862f1f49c@youngman.org.uk>
Date:   Fri, 22 Apr 2022 00:33:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 01/12] md/raid5: Factor out ahead_of_reshape() function
Content-Language: en-GB
To:     Logan Gunthorpe <logang@deltatee.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-2-logang@deltatee.com>
 <b0bd9204-1f76-aba3-b754-464e28763f59@molgen.mpg.de>
 <3252df44-5856-c1ed-174e-18748387cdd2@deltatee.com>
From:   Wol <antlists@youngman.org.uk>
In-Reply-To: <3252df44-5856-c1ed-174e-18748387cdd2@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2022 17:05, Logan Gunthorpe wrote:
>> I like the ternary operator.;-)
>>
>>      return mddev->reshape_backwards ? (return sector < reshape_sector) :
>> (sector >= reshape_sector)
>>
>> Sorry, does not matter.
> Yeah, I think plenty of people do not, though; it's harder to read with
> the long line and awkward to wrap.
> 
I like the ternary too, but is there a superfluous return in there? That 
would shorten the line. Or break it on the question mark - condition, 
true, false all on their own lines.

Cheers,
Wol
