Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDB0596238
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbiHPSOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiHPSOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:14:40 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C111830F63;
        Tue, 16 Aug 2022 11:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NQKadt4IGOnVF9gAUaxkJtHM05nptXAHtJbvAVHhV6c=; b=R9JhU6r4tJm3iGfQfHYFx51MS/
        e3gej3Ta7IBKe12/T8m0kPZ2LGTRqULTcn6KiqgbQYtCs//laj7TfaP8cxaTZhIkrRUUtOPfUN4Is
        19aFaSpZtjF+H3YGoUfjKDbFaGnM1IEVyakJkqjy2sMSt0RhO1D2J1Q43EH5X+aeqvQ5hRjAvRGwg
        yf9WuY+qP11DFLFUiGo6LmNnUO3qK+5mJzOY9cVZ6z8cgWJUfXD92A2fLWTZNXYfvAsQjVdQAy6eh
        lYZq82PVhU/w9dNMeeCL0F4ZRczJcTilnD/GTc27RP9GgRxyhStmFF1x58zUi4YCe2ptk+kGTvtgh
        8MxrCw3w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oO155-0058cr-Pv;
        Tue, 16 Aug 2022 18:14:24 +0000
Date:   Tue, 16 Aug 2022 19:14:23 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Xin Gao <gaoxin@cdjrlc.com>
Cc:     dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org,
        serge@hallyn.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: Variable type completion
Message-ID: <Yvvef4vCFaYhMjMq@ZenIV>
References: <20220816180110.8625-1-gaoxin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816180110.8625-1-gaoxin@cdjrlc.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 02:01:10AM +0800, Xin Gao wrote:
> 'unsigned int' is better than 'unsigned'.

Explain.

You keep sending rather pointless patches with declarative
commit messages instead of explanations.  Why is 'unsigned
int' better than 'unsigned'?  Demonstrate understanding -
simple reference to checkpatch.pl does *NOT* count.
