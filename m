Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B2657B142
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 08:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbiGTGyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 02:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbiGTGyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 02:54:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1D4313B8;
        Tue, 19 Jul 2022 23:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658300040;
        bh=jL0qhy7UaXVfEn5N7vL9Q+NNCqml/OPeBCP0K856yLM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cbqD/2JqCqD1dzSRBX4gdIAS25JRzVjkZtljIX3ch1pBJpEExoYtXYVfErpJBJnCZ
         qRq22nuFB/lM/fpjJ+/17+6m8Yb9grvGJtX3fYkp7T/NTHkfx1rk2ysLVEzpvZGaYL
         IPE+rfwQ3FphS4ITVfqTfGxcy6/vJWyc04ZiqcOg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.166.214]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6UZl-1oBbov23s9-006zod; Wed, 20
 Jul 2022 08:54:00 +0200
Message-ID: <860792bb-1fd6-66c6-ef31-4edd181e2954@gmx.de>
Date:   Wed, 20 Jul 2022 08:53:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: WARNING: CPU: 1 PID: 14735 at fs/dcache.c:365
 dentry_free+0x100/0x128
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org
References: <20220709090756.2384-1-hdanton@sina.com>
 <20220715133300.1297-1-hdanton@sina.com>
 <cff76e00-3561-4069-f5c7-26d3de4da3c4@gmx.de> <Ytd2g72cj0Aq1MBG@ZenIV>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <Ytd2g72cj0Aq1MBG@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A+Jl1Eoj4mUmFbeHDf48LmNFwgwxjO4nSeLqyxJ1ylHwAcysdAO
 qT19i6GNnmljANR4MoumJN4QwrgM+UserjL8xUrRcDnRopKUi9X1qJg0uJU9obykK5i+G+W
 T8uNEWrj8JBC6xwqwV2n2QG9sQo1QBPVMLfKUIBDmM4LGFWEaoJtvyJ2yMFwy8LlUvrYnSB
 H5HH7tPAFKKi4ZKJfW3TA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:atGPOWriFzc=:b9JUuqfNJa5JcB8s5LRyRa
 WHTxvVHH3c9wsMQs/0aylw3js3N0R3QRzyX8ZHs7ZP8ZcPkZTzy+AlqWsD55iidbZGOVvRgvg
 ONKQhqGpRT8BB6eUvYt4ohz4WlxFOEeRN5dF2nei4R7CRUPiJZyJyTIGz67QtnA2SrfARlQpl
 i978mF9fLz3x13JmXOPmrRhZF6dWHjoARLcBy6EusPiln0DMPeN0RbpS4fxBwFUVCgP/EgkdO
 NMRG1vrwPrCvutwiRWMPCB521mozWC5sMP/fzeOEJNuunoTn8XeyTRp6+TMs21C/Hb4S1N6TZ
 btAdhWcpxc+owBvVhglDK+3jN1eTmg3pnji8JI84LOK80JhjDrGMiYMH5x0CXx34/aTBYCyMU
 pgoBZl9Y6NW5EbX+QAKbZ0f31s10hkx/tQ1Gdg0CisLa99TgMjy+C2+ZVgA5HRec7M/MLtTlX
 xAojsgRFf4cu2nu07pSbyCOx0YMvVzTv62n9G10SpYSWsWqGWEmTCidxjKbqJLUhDTzXDqXnn
 F1M0k/0/HQGFI2lcWG6L1wITpGA5y1TTxtTzXpVYc1j+YUAVodulpGnhra+CFGrw1d/09FkL6
 PqC3XEP9q9g1SKEznQtyrsyaKFBwmX1HIcPfbjb/5ys8c2K6AuHb6hoYR3vPLCaVGsZMplxfa
 W2Q+1oIDEVjSAG4C+nGGI7+tH+XlH5ZyjmkvrLAwNhIBBvDzsiJl0JkPqWG2zSoWNfdcUUph1
 AhGTr2BNdk5pdpd7JpwN3rmA9aWnTfYK/k/IjgDdMTIly+/+ighNHW5ZgNw8oF2EFKwSYMIvU
 wfHdzWwLydNiagE7YQCxiKdWuaLXzRwHpfj+kRJ3e40OVvcwouJhan0s43ds0q/cC6jHBBsMf
 xeS5cZORCEO9MZCBI7CkjffejWFyps8ENn64YUDRMk2QJJlUZQ9+uWghvTvrqvlyYfaY22Q8E
 N/ttVnLSzgPtaJjHh9LNDvOqMFjqFyoVHBKht5CjKaX+wI2iaMsDqqA6FY2O4BwCgBFuGSH7k
 nKWwPXaw7EmhOX40avnrNYsacumfa/dOs7RYkswG7Ag2ezUvr2M7XbGNmxKhjiVZYRQV2yRdH
 bDdVvMjyFGjIlizxdQEGy5AfyIktDF+VhjdbIkLbOOKcaQ+vq+TNSs8fw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/22 05:29, Al Viro wrote:
> On Sat, Jul 16, 2022 at 07:27:30AM +0200, Helge Deller wrote:
>> On 7/15/22 15:33, Hillf Danton wrote:
>
>> [108565.341434] dentry->d_u.d_rcu =3D 0x416be770
>
> Incidentally, does that match the address of __d_free() on your build,
> or is it something different?

I don't think it's __d_free().
The source is:
	pr_err("dentry->d_u.d_rcu =3D %pS\n", dentry->d_u.d_rcu.func);
so the "%pS" would probably have resolved the pointer to string "__d_free"=
 (or something else).

Helge
