Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C77528D53
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345069AbiEPSn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiEPSn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:43:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7030F3EA87;
        Mon, 16 May 2022 11:43:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652726632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hR0g/69/6yafTNMHGbFIjFGN3eZ6lE1gFBvP50Z8AxU=;
        b=TeAbVnMTJG1LbUa/idMiHC6KQ9kBnjn/g/biW0agexy+eXDD+ZCVnDZHAxuo6GgLBzY+5N
        2A5Xw8zgHtoTAh/or+f00mzggrlvL1hmvdlfPa7PVH4Xw+fiPwK3f9dJIa8a7hj9173kfq
        MF/47IIWZYk8cmF/v58R5PhUOeJVPG+0A5SiakKWYBe8wbQXARabTLYQo7YABRwGoLxCwL
        qfSzz7jrBai9iajPP8bCHEcGbEg1E/YwCsnmGd3xN43jKwv2pq8RDKn7lDCsNUk5IRfcd4
        KU6ugAGXrF6N4trujVSQcAhm41OCzQc0bcimgyPJsNROVayYb4Y4d4/A+U0UjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652726632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hR0g/69/6yafTNMHGbFIjFGN3eZ6lE1gFBvP50Z8AxU=;
        b=k/ief/N4zghzjOp1cXZhIZH4TiOooTG5wjHCbpqyKfInoPrlD2VtqNCoW+z/Te8Q9iw7KQ
        P0FZYdmx8i03f0AQ==
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-spdx@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch 8/9] scripts/spdxcheck: Exclude dot files
In-Reply-To: <CANiq72kSqKqoUsiFhg0+a65vc3KPTW4zpt-Dh8geVWUMPkWFwg@mail.gmail.com>
References: <20220516101901.475557433@linutronix.de>
 <20220516102615.884180377@linutronix.de>
 <CANiq72kSqKqoUsiFhg0+a65vc3KPTW4zpt-Dh8geVWUMPkWFwg@mail.gmail.com>
Date:   Mon, 16 May 2022 20:43:52 +0200
Message-ID: <875ym5qpw7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16 2022 at 16:22, Miguel Ojeda wrote:
> On Mon, May 16, 2022 at 3:55 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> None of these files
>>
>>      .clang-format, .cocciconfig, .get_maintainer.ignore, .gitattributes,
>>      .gitignore, .mailmap
>>
>> have copyrightable content. They are configuration files which use a
>> publicly documented format.
>
> Should this files remove their SPDX-License-Identifier? If yes, we
> should do that for `.clang-format`.
>
> As another suggestion, we should check that the ignored files actually
> do _not_ have the `SPDX-License-Identifier` (i.e. so the above case
> would trigger a diagnostic).

Good questions. I'm happy to drop this patch for now until this
discussion has been settled.

Thanks,

        tglx
