Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93AB4B79B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238909AbiBOUxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:53:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbiBOUxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:53:51 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDFD626AF7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:53:39 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nK4pP-0003YA-00; Tue, 15 Feb 2022 21:53:39 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 8C25FC24F5; Tue, 15 Feb 2022 21:52:56 +0100 (CET)
Date:   Tue, 15 Feb 2022 21:52:56 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Nemanja Rakovic <nemanja.rakovic@syrmia.com>
Cc:     linux-kernel@vger.kernel.org, dragan.mladjenovic@syrmia.com,
        elver@google.com
Subject: Re: [PATCH V2] mips: Enable KCSAN
Message-ID: <20220215205256.GA27866@alpha.franken.de>
References: <20220211162142.2402-1-nemanja.rakovic@syrmia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211162142.2402-1-nemanja.rakovic@syrmia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 05:21:42PM +0100, Nemanja Rakovic wrote:
> This patch enables KCSAN for the 64-bit version. Updated rules
> for the incompatible compilation units (vdso, boot/compressed).

I've applied your first patch, please send a patch, which applies
to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
