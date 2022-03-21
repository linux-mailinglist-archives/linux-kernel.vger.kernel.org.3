Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9499A4E265E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347357AbiCUMah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347335AbiCUMa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:30:29 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41003DF87
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Jr1ZLs7cdsoRFBEY22djs5MKyrd9wQirB+eEW4f9e3M=; b=f6DA+B/dmje1YHC2W6jYmrhSLo
        kRDhdOtxpd2i8lgI6LjLrQWZDYVQnFowXWehLmiQ53gqYL4wUzmNoBDc/Ltfd2F6makpCxQyhRMo4
        ARwdK81e9WXygF8hUpGFZMi9vamvCwfCavbB+yLsjHDQRCHMYy3rtz6j8mSH7zXj/SKqvc0BYOA6f
        hXQ8UGAHlPl+20y1EyZTqhbJecgCn1hgxBtDUOUz37rGhdGl4Xbnd92RlCB/1YBNfk6PArvki1GCm
        gdt/RLEwP0E/NzlBAgK9PAue6EvxHOttjTUkfdBOavhEqbzJEL6XoJBJZ+TLJ3teWGMzTTspdzki3
        cPSy5Uyw==;
Received: from [187.39.124.208] (helo=[192.168.0.110])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nWH9I-000BLL-CG; Mon, 21 Mar 2022 13:28:36 +0100
Message-ID: <1ccc06f4-3fff-8a6e-2a66-3f117ca6f282@igalia.com>
Date:   Mon, 21 Mar 2022 09:28:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC 0/4] Support kdump with LUKS encryption by reusing LUKS
 master key
Content-Language: en-US
To:     Coiby Xu <coxu@redhat.com>
Cc:     kexec@lists.infradead.org, Milan Broz <gmazyland@gmail.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org
References: <20220318103423.286410-1-coxu@redhat.com>
 <c06a21cc-e1c1-e627-f908-ebc2a041e29a@igalia.com>
 <20220321014150.w6wux5azabweu7dr@Rk>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220321014150.w6wux5azabweu7dr@Rk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2022 22:41, Coiby Xu wrote:
> [...]
> 
> I believe some users have security concern for where to save vmcore.
> This use case exactly fits your description and your proposed solution
> shall be good for this type of users. But I think many more users may
> just choose to encrypt the hard drive when installing the system and
> they would naturally expect kdump to work for the case of full disk
> encryption. So your proposed solution may not address the latter case 
> where there is a much large user base.
> 

Thanks Coiby, makes sense, your idea is more generic and seems to
address all the use cases!
Cheers,


Guilherme
