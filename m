Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0624E4CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 07:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241989AbiCWGeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 02:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiCWGeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:34:09 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7EA716E2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 23:32:41 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.71.26])
        by gnuweeb.org (Postfix) with ESMTPSA id 3EE637E342;
        Wed, 23 Mar 2022 06:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648017160;
        bh=CF8WJ3FjZlYY48Kavdonn1NzDNE0CVAJZB201YjIl+k=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=OKk361GtmEZQqabD0dY5tgo97CpTUcjIhv9cnCHxq4NxknlUbUBz99iSH+QoF1vR9
         uJQOx2+N9SLSfyET4ZqkF+JZ8A26Z9PJZokZFNg0X6TskzIXd3roZoOlw7giLLZMV+
         6mdCqVh9kV8SHOkwMr7yVYPZo6Jazq4WNfYbZSdP6VgJpKQ9qhnX6/UUyW8qTHgAId
         e4Rrc3L83fkiEv6g95RcGDVlhiYX4+5h8NqON8Fgr9smapiXOyHkTKEtJ2ZYaojOOi
         G4Kan3MBmt/0sZBM5YtkDixMLi+LRppjS7EP7tSC0i0Kho4ry0kdx6RUjBa6WlA0Ch
         RMBczW1kTEmyw==
Message-ID: <e7fc541c-224b-08ae-1a92-ad9a03e3d9b1@gnuweeb.org>
Date:   Wed, 23 Mar 2022 13:32:34 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v2 3/8] tools/nolibc: i386: Implement syscall with 6
 arguments
Content-Language: en-US
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     David Laight <David.Laight@ACULAB.COM>, 'Willy Tarreau' <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-4-ammarfaizi2@gnuweeb.org>
 <8653f6784a9b4272a59a75a530663567@AcuMS.aculab.com>
 <a8eeec1d-656d-15a3-dde5-0f8cc8c5956b@gnuweeb.org>
 <20220322121338.GD10306@1wt.eu>
 <22fd9709b3a64a548226741b682ca155@AcuMS.aculab.com>
 <2eba5687-6b63-ceb2-3fbd-3d236727ea11@gnuweeb.org>
In-Reply-To: <2eba5687-6b63-ceb2-3fbd-3d236727ea11@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have reported this bug to GNU people.
   
   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105032

-- 
Ammar Faizi
