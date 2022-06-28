Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADB055DE9A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344261AbiF1KVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344618AbiF1KVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:21:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92C62F644
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:21:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88E18618EC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CC4C3411D;
        Tue, 28 Jun 2022 10:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656411661;
        bh=mpFmPgrVnrLD6WmEqTWSY4rjyQP+nOfAeE/fmNB5/G8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tFOjbIuWliqESkb8bUiyvV4LxkDhkllxef3867Z9JHpAnKGzq9QmlTI7qcCsz6vC1
         Xaib9wZpLFxY/jm6253QLgW6ZLNzszLHSF1+yaW5UnBUJgh70Xenyvm9SbHEx3pgBJ
         65sZdtVeHTIRUMd1JFlwdUVwnV/Jo2KreHmUCfy+SsEbLzAM+d5MphQe4oEDDAXrm1
         +K9kbDkd/0dex5wbK7OC6FgERs/kn/d6Y2uzBDTmILWjXsNngDZIunKz4QBAeDQoXm
         CBZSK0n6LwFWypkue4/Pajz3PSFocvdb2RcKQla/T9VdeGAo/o/JX6nhym8wk9PgeG
         9UZf/cicW2axA==
Date:   Tue, 28 Jun 2022 12:20:49 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Todd Kjos <tkjos@google.com>
Cc:     Carlos Llamas <cmllamas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2] MAINTAINERS: update Android driver maintainers
Message-ID: <20220628102049.fbxadvjiww3uwe6u@wittgenstein>
References: <20220627192434.2306065-1-cmllamas@google.com>
 <20220627194753.2309523-1-cmllamas@google.com>
 <CAHRSSEwVq0Jhf2v1NY4LUr7hTJXuU904BU1XMOdA-fB0uXfUqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHRSSEwVq0Jhf2v1NY4LUr7hTJXuU904BU1XMOdA-fB0uXfUqA@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 02:09:12PM -0700, Todd Kjos wrote:
> On Mon, Jun 27, 2022 at 12:48 PM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > I've been contributing patches for binder{,fs} targeting fixes as well
> > as new functionality. I've also helped reviewing some of the incoming
> > changes. As such I'd like to be added to the maintainers list for the
> > Android drivers. Note I'm also dropping Hridya's name from the list as
> > she has now moved to a different role.
> >
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> 
> Acked-by: Todd Kjos <tkjos@google.com>

Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
