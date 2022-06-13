Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732F8549D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346296AbiFMTPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244254AbiFMTOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:14:55 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470E0DFBD;
        Mon, 13 Jun 2022 10:32:19 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8BA722D6;
        Mon, 13 Jun 2022 17:32:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8BA722D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1655141538; bh=CAbykZa7LGiaL2uhDi89WkbWfjlRfKkHuNP3EFQo03s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=N42M3GdSdWLMCo+/tgB3jVt6aSIRdm0RFtxr9QoLJDLbbauCOZZV/SFLtBq062D/1
         5Xg6JO9smW9/dAEFIJ/0RoQmwP9F0pyqRArtYuljLm2oZ/4zO6qq5vVAXSjFBjcXTC
         1mFyIB2na3LoZwX+1rNLS82NQfN4to/Cmyv1fqzBYqr1JYLL74DBwJd952tYKuN10o
         ADVUzrwcwkHQsCnt9aqd6y2HFKPTAV+xT9tYuYoPxa0VuYBDGmJrn9zN7CSFgi5CCF
         v1P6gGOmFPz6guG2M4pHFzDL4pof3LEBOBr60sNzEtLf0mVbuVKQIwtWdemeNDmKMi
         B43eEj9evcuzQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Martin =?utf-8?Q?Li=C5=A1ka?= <mliska@suse.cz>, akiyks@gmail.com
Cc:     bagasdotme@gmail.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mliska@suse.cz, will@kernel.org
Subject: Re: [PATCH v3] docs/arm64: elf_hwcaps: Unify HWCAP lists as
 description lists
In-Reply-To: <d0e576ab-6121-b7d7-da5b-7750f05ca7f4@suse.cz>
References: <0846c96d-62fa-555f-b0ab-1f5ec33fd5fb@gmail.com>
 <d0e576ab-6121-b7d7-da5b-7750f05ca7f4@suse.cz>
Date:   Mon, 13 Jun 2022 11:32:17 -0600
Message-ID: <874k0o1nby.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Li=C5=A1ka <mliska@suse.cz> writes:

> Signed-off-by: Martin Liska <mliska@suse.cz>
> ---
>  Documentation/arm64/elf_hwcaps.rst | 23 -----------------------
>  1 file changed, 23 deletions(-)

This patch has been sitting for about three weeks, which seems like long
enough, so I've gone ahead and applied it.  I've added a bit of a
changelog to it, which I'd rather not have to do; Martin, please be sure
to include a changelog in future patches.

Thanks,

jon
