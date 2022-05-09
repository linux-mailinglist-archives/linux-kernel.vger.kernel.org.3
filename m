Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEB9520771
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 00:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiEIWVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 18:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiEIWV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:21:28 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0E226BC96
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 15:17:32 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 584EB750;
        Mon,  9 May 2022 22:17:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 584EB750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1652134652; bh=IcjDZ+vliWALR52qBcrsOs2f6MFNys/FXcJOIkJdsZc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=U73kGPubOhRDSSgICRVwfGgUHn5LJJbwg5VvsGuLb136IozRY9xj2CPV+INDMRSI+
         8gVR0i3hWzV9lQufl6uGkDXBWdLGrL3ZpTzgp6tfU6bdBr90U8yC4KNi4BheSrJSIW
         chk0Vxdgv/1HgfwGyR/KR0nlWzBx9LuV/PdsGZ0Qwin3XBD1HlSxP5q2A9lMGqGpUi
         vW9WJckYLFEhDXWZs/fy9psYgDemzKSJFnGleDISpresQAiFhGfSM15I3l2YbwB576
         wiEikSxDvy6ojFElYIjSrrA3Zz3E3kNp4nme4f0sf+0itcPyPfhUYAV2Wk7lz2ftxA
         PB1CULq1Z2ZGA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Phillip Potter <phil@philpotter.co.uk>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 3/3] block: remove last remaining traces of IDE
 documentation
In-Reply-To: <YnVgxEcRTQPu/DHE@equinox>
References: <20220427132436.12795-1-paul.gortmaker@windriver.com>
 <20220427132436.12795-4-paul.gortmaker@windriver.com>
 <87wnfaa8ce.fsf@meer.lwn.net> <20220427165917.GE12977@windriver.com>
 <YmsmnGb3JNjH54Xb@equinox> <20220506153241.GH12977@windriver.com>
 <YnVgxEcRTQPu/DHE@equinox>
Date:   Mon, 09 May 2022 16:17:31 -0600
Message-ID: <87bkw6cpvo.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Potter <phil@philpotter.co.uk> writes:

> I was yes, the point I was trying to make (poorly) is that your patch
> conflicts with Randy's patch which itself is not yet in linux-next, as
> normally I send everything together at the start of the merge window to
> Jens, as I don't have my own kernel.org tree yet, and usually I only get
> one or two patches in a cycle anyway.
>
> This is not your fault, you couldn't have been expected to know this in
> retrospect, and I should probably look into getting my own tree/GPG key
> sorted to alleviate this problem in future.
>
> In the meantime, if you're comfortable with the idea, I can just resolve
> the conflict myself when I send the patches onto Jens this time and
> include patch 3/3 pre-fixed up. Merge window will be fairly soon anyway.

So I'm a little confused by the state of everything at this point, but
I'm assuming that I need not worry about taking these changes through
docs-next.  Please let me know if that's not correct.

Thanks,

jon
