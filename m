Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDE64D3D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 00:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbiCIXV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 18:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiCIXV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 18:21:27 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C51D56765;
        Wed,  9 Mar 2022 15:20:27 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D9F432C3;
        Wed,  9 Mar 2022 23:20:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D9F432C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1646868027; bh=QzLUU5mPra8AFEM4QUhgI2YBj6DwA7TTvMrUWq+e9+M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KUppseLPyiLaTsKqtczeB153um/WfRlKBnQgn3tIiBLSkZH6p6hSTAYdrIK7QnVYz
         EN+iVUco4zxlvvz/uU+kHmKUtaUVMauMwTiuMCF3KoWqaWPSUSzmEcnnbKAYn4BJGn
         SchGSYIf6sEopdzkwlAKof4BBY+DGsVdkjIW2i9dl8J1MhixYzh7DPUrqYw1iHI2Yv
         aRjapvQa62IjW6c5r1peQD9xDxxn1sxIjREF/WbcC7tDlZlSk6iAl5giLV3FJKnWvR
         atHJDfNsvH2FBcwW7xhUZVK9YoI2oa+HoLIFOkE5Y1WF+yPYSuPyORNInoCEm1N8ZB
         Bd35Y7U7UT0wg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefano Zacchiroli <zack@upsilon.cc>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Wenwen Wang <wenwen@cs.uga.edu>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] Documentation/process: Add Researcher Guidelines
In-Reply-To: <20220304181418.1692016-1-keescook@chromium.org>
References: <20220304181418.1692016-1-keescook@chromium.org>
Date:   Wed, 09 Mar 2022 16:20:26 -0700
Message-ID: <87zgly7lxh.fsf@meer.lwn.net>
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

Kees Cook <keescook@chromium.org> writes:

> As a follow-up to the UMN incident[1], the TAB took the responsibility
> to document Researcher Guidelines so there would be a common place to
> point for describing our expectations as a developer community.
>
> Document best practices researchers should follow to participate
> successfully with the Linux developer community.
>
> [1] https://lore.kernel.org/lkml/202105051005.49BFABCE@keescook/
>
> Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Co-developed-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> Co-developed-by: Stefano Zacchiroli <zack@upsilon.cc>
> Signed-off-by: Stefano Zacchiroli <zack@upsilon.cc>
> Co-developed-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> Acked-by: Steve Rostedt <rostedt@goodmis.org>
> Acked-by: Laura Abbott <labbott@kernel.org>
> Reviewed-by: Julia Lawall <julia.lawall@inria.fr>
> Reviewed-by: Wenwen Wang <wenwen@cs.uga.edu>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v1: https://lore.kernel.org/lkml/20220224001403.1307377-1-keescook@chromium.org
> v2: https://lore.kernel.org/lkml/20220225201424.3430857-1-keescook@chromium.org
> v3:
>  - move to /process

I've applied this, thanks.

jon
