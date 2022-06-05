Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6503E53DAFC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 11:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350913AbiFEJWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 05:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiFEJWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 05:22:21 -0400
X-Greylist: delayed 1445 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Jun 2022 02:22:15 PDT
Received: from outgoing9.flk.host-h.net (outgoing9.flk.host-h.net [188.40.211.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241BDF5B0;
        Sun,  5 Jun 2022 02:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=risingedge.co.za; s=xneelo; h=Message-ID:References:In-Reply-To:Subject:Cc:
        To:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:reply-to:
        sender:bcc; bh=81rFA4BpPtRyX5WIoLVbWn5+nyR/z805/TPWfclV1s0=; b=Oa0H3jB32uDsmz
        +IKonKDzxaSuDRYjxtuo15zhrFUJjDVvSTImGSOcXNWGwsm3czfxf0tualsxT37Lz6/SP+qIko5J5
        wwNiU6nLM9cOm8lLEWHxkeR0TlYk1TaPfcG6XQS9a5yqplvmjgmnL+/ezJXzzsfCxLDpRSDBMPrG/
        Pq0NLeMiMQrkxR9ZfcLcG5DyFsWMpgvtBmVGeSfayae3zUhLpJemZ/YaTHUSvHpIM3WIIE92zjkIF
        J3KIMLnnpIzmErMaRQObXHGPJeQHfEf9puOJoBKeUBoyRkfRTyBc2QXvdhVfGlS3+c9Mn+39j8BCJ
        Td99Sns9WKPTVLDZO0SA==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
        by antispam2-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1nxm5F-0001TG-HD; Sun, 05 Jun 2022 10:58:08 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
        by www31.flk1.host-h.net with esmtpa (Exim 4.92)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1nxm5E-0006K7-6I; Sun, 05 Jun 2022 10:58:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 05 Jun 2022 10:58:04 +0200
From:   Justin Swartz <justin.swartz@risingedge.co.za>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: usb: fix literal block marker in usbmon
 verification example
In-Reply-To: <5f00819a-cd52-a2c7-77de-28a4649c33dd@gmail.com>
References: <20220604155431.23246-1-justin.swartz@risingedge.co.za>
 <5f00819a-cd52-a2c7-77de-28a4649c33dd@gmail.com>
Message-ID: <f2943c036e1dd403052dcbd09ac4eeae@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.2.3
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-Originating-IP: 188.40.1.173
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.28)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+mtoaHmpMdGeL1Z2cTqV23PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w1OL79HMxE022P+rQy8YAdcSeERs4TOTnIH1kc1IWc5cqv
 NIMzTsl2qXZAml/tmiq3wL2Y4F0412ezGCyTUPanTItOOFNNjY132/lViGIyGqLI4OY9HO9H+Fx9
 YIm3grPYonhfr99jXBd3p8VVa7wrtuUNWnipPNRiS8q/FrUUyhphs7d9t3h8/eH7VpZdYpSaXXo+
 XOEihNRo6fZjI0Myux047PMkZ2I4O0Gvdk9AAW8x1ETXYTQWLZHYPGIRSJbQfPrRexZ8zPn1aO3h
 DN/K5kF1BO8/KDJZ4ltq0FmDUHbRpMw6Agze1f399OurHExyip4dg7bMhKpN2ppuF3xZg9qILtOc
 x496K4yViMb8jHUZF5wtMQihNn2ibuRmUFbnT6Zph4wUZj+IQLUKRJze24jc5ICzcKZaSHLJZLzx
 6aHVQKD2bbQkin/3b4lwCl1eeskTxc5eCFjiFT1T9n6Q+lw9VAxgT+0czURNlTTIUBgMoMLqMwiy
 XvPmgw+DKHHjBLgSt4z9qWdf+kVLYSLP4vz3kgNA/j2ci96BpJKMLGv0xI1YXOxC1lZqyFpLAwRC
 ktFFkLNUM1fTMKwv8cz83kRyQJ/ZGaXs0EPPKndCG9ezYqxGMqsKjARq8PBC4qh3MISx4KSQOBWf
 64/T3KSNcpcFwJzPuG05YeslPlAFPyCv9TR+UxzLZWL8hwGBjhpycqo+C5ZwUO4BfhdA94X/ibY0
 C+AjizwdGjekSm07b3ibm+5W1r7gQWTgSVHBW4qloQDNNjdAMCVgoKkZMil4qltTledIt9ijODyQ
 sQMzJzSbmbxa2vI/GkwemylixmzgD1oW92xgJT5DBL7SQgcmFb9Mfc3rLBZL0iDs6nUKmZIjkW6r
 jpq9JeyppgeQoadDOjqPH696SEBPk7q9MTcQ19jJzN60CNyc6/mOEULY0nosUsvFcXDE2GHJYs5g
 b86PuP6Tuj0pdeMY+nPMjKsPAEU1y1EIxG15YQ8/tfZopGRqaSqL710Mawj4PIvmTctJ1duNYzW5
 OyyvJ5b4zn152Ny5UbkAItgqYdjyvkX5H5Ch7XAUmiF08eWpr0No8Pica5FQnF0BJAuYeQUAl42c
 uTNa7IVsbMNf4F0zLZ5qoXKO5R9R9ZXdgTfWwhTblPq+jrsZSXtmLqDWqko7ZvXA
X-Report-Abuse-To: spam@antispammaster.host-h.net
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-05 10:39, Bagas Sanjaya wrote:
> On 6/4/22 22:54, Justin Swartz wrote:
>> The "Verify that bus sockets are present" example was not properly
>> formatted due to a typo in the literal block marker.
>> 
> 
> Missing second colon?

That is correct.


>> -Verify that bus sockets are present:
>> +Verify that bus sockets are present::
>> 
>>  	# ls /sys/kernel/debug/usb/usbmon
>>  	0s  0u  1s  1t  1u  2s  2t  2u  3s  3t  3u  4s  4t  4u
> 
> Otherwise, the literal block rendered correctly.

The block is not rendered correctly without the second colon.
See: https://docs.kernel.org/usb/usbmon.html
