Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C365A285F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344298AbiHZNSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344313AbiHZNSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:18:08 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947E5D25FC;
        Fri, 26 Aug 2022 06:18:05 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E4FB24B0;
        Fri, 26 Aug 2022 13:18:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E4FB24B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661519885; bh=VtRTsWzEJlrHYKSbEjzrBwyUxA/ZI3RZLpC0o+8o2nA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TuTcNFbkXhWBkC0KbL8cto36vgRZPM2ADhRX1OQgiP281Fb6/6XVqMd1r+nBSUwDB
         aJ95uVelQHPN/2tdJWC6dsy1yfvpPX0zqoPtyuXZWk63hzQr93arWHt+U9nDBrITKB
         El5WiSa7EcD0mYlg6E3YVyLWKKEWsawM59w+cwYKemlbOGPBDm9M0rpHG6ZxwxekXU
         0PmLah5xK+/4oL74iuYxGqbNH2m+y7J/oNrEUXkK8mdY0djwAFV02t3+K93QMZgIsZ
         6LUjylpIP0Z6EuFZhZbfipJrECn6EPtMeJR6KS95UGpsVNlr+ldi7Hpo9O+id2h5SN
         mdRqjaSTiLwjQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Update version number from 5.x to 6.x in README.rst
In-Reply-To: <YwgtoiKl5Azt7Pre@debian.me>
References: <20220824080836.23087-1-lukas.bulwahn@gmail.com>
 <87a67syxa0.fsf@meer.lwn.net> <YwgtoiKl5Azt7Pre@debian.me>
Date:   Fri, 26 Aug 2022 07:18:04 -0600
Message-ID: <87fshjw3cj.fsf@meer.lwn.net>
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

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On Thu, Aug 25, 2022 at 12:48:39PM -0600, Jonathan Corbet wrote:
>>  - applying-patches.rst should just go.  I didn't prevail last time I
>>    tried to make that point, but I still don't think that we help
>>    anybody by dragging 1990's instructions around now.
>> 
>
> Hi jon,
>
> If we're about to rm applying-patches.rst, at least we also need to add
> a warning to the doc, saying "This documentation is obsolete and will be
> removed in the future.", while adding the same deprecation message on
> scripts/patch-kernel. The script can still be usable and kept around for
> a cycle. If no users complain, we will go ahead rm-ing.

A document isn't an API, it's not like users need time to somehow
migrate away from it.  If people will be affected by the removal of a
document, we probably shouldn't remove it.  The situation here is that
nobody is likely to care.  *Somebody* is probably still updating their
kernel with patches somewhere, but they know what they are doing by now.

A script is different, of course; removing that might actually affect
people.

jon
