Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936A55675BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiGER34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiGER3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:29:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3E121E0E;
        Tue,  5 Jul 2022 10:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657042116;
        bh=VGuEIUsr6EgBwogMJDOlNkr+9uptYB5Wf1LvyW7VLPs=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=k9laCBm26jQJsWLY6/OA9x+WAPD5XpUnuCifOnFPctKiq8Cxnh7hq273gQq2RJdYz
         2x5Ne8LKjOfMOygKyKjUcqOxmXyq9y9ZosWNwexF86QDY05yjhOO9XCcbd++Ja4s5W
         POdhnW6nskUpMGLRl/Yr7vhiOyCfotuuhbHfxFZs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.101.2.50] ([185.104.136.29]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUosN-1o09Uw3n2v-00QgAB; Tue, 05
 Jul 2022 19:28:36 +0200
Message-ID: <3b9e115d4b8b6f363c45fe510e822e16fbce9a25.camel@gmx.co.uk>
Subject: Re: input/i8042: Malfunctioning brightness keys on HP Elite
 Dragonfly G2
From:   Alex Dewar <alex.dewar@gmx.co.uk>
To:     dmitry.torokhov@gmail.com, tiwai@suse.de, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Date:   Tue, 05 Jul 2022 18:28:34 +0100
In-Reply-To: <20220629094314.b7xmfb3xccj7vs6v@ic-alex-elitebook>
References: <20220629094314.b7xmfb3xccj7vs6v@ic-alex-elitebook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Provags-ID: V03:K1:REy3K7T9Qlwri9ohxu/egDgFhzFhT7M3kMFMrdTBrQajFYVRZC2
 BY4VI8TN8UBuJOGH9RJMtWtHwb53i+o4910Cz7VT4t6BktFUU7kMjEmE2RymY1oI7LitSKO
 jL3FvJPeXlPh3P3wuP0bzdvJaEx1o+gwVEoDuoam3gK5CZ4mEro45f470hCS/IBR4d4vmaP
 WMdN/rWgH4vZintxfdzug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pfzyXE/Hyfk=:9kG1SCIL5eQTPjd1fagLEk
 7eqgpVqBK50MW4oDfkzE6M3KVrqrMGyGf5y2eBSEzGzoAJOd514olp323L1s/NONROAgnJAMh
 MWWY7zq6o4Cr44wLe96wPfW3w9jdxctjXizaC5J8uS7/rHu+GU/KmHhUO5o+nUPXdzsXxIdxv
 FtErBdMHqFKUMkQYXwgU/sKzktATR2eteFmRx9f7Nw2uSyBbotg1vJy9Jrz3gWo7b0GoJ8Hv8
 eb0SiPEWc1yjhMMGG56V9a/yIX5Z/QZ/9noF6Tj8ztFWSQYolbKk44E4YkNX/a0JH1X2Nbj2J
 F1Wcv4agbGBmFyqUOtncWWTLnyRDIH+qkngbGgD4uxY+Xgl4XeW+gRcq7fQ8Pbkk3oW9vvoYl
 vFGtwe8GtVi+ap7Bm56tKGKNMBNLchWWxtp8aBH03quBR9AzZscmYWSBRZgsQ5IYeqGM4K0X+
 zybH/ngfjyKvpYcs4Snj8IjHK3Ya/XUCIIRfQzTZuFBVPf9z/lzEkc4+BBwo3WM0qja+6RPVo
 qWvCY8oSeqOOBEnL9adceuuNO9HFYPJNkfdIWI5zkPtT7mJmXsrqPYrbCtN3rgiODZh3DwBZU
 brGDl5SeIdh8Hjh3VcsoNPtknmujOrSE2lpwlrZnpK2P/CYNcSB0CS1TTapOKjlMFIukh1OnT
 Zi+nGVah1N8PzuY62sHsRCz2P4YI83fl1cKcrJx5Cl7fXkdzauPwHx7yfzk7G0jyCzEXzXRNt
 yKlUmG/mwsjaH3Hltj1PrOPrxlwJ9ml0RzbaJJ/8HMlXRAgI2Inaa5dtJI42hV2Jd70hVmybn
 xj6CEzzzNa8W7Y6xBmF1bsjRBy7jb95EanGSNn+/fdZwPdouFGBIHrWiWIQYSOW7x4bW4U+Gz
 dOTACT1rAZ3Ps0vpdc7gx77XNaYuUj0T14YoaHYAmYmK16q67rvSL0Ef2ZTN3E91WARS2VPXg
 RzofapGmCTo5hSygtGXKRD74/T3KdzlZnozYJlCDBNOrt6OdIbogK1U6fayxsIG6RO3PLdRVn
 DPwmWS6xaB5DdHvY+3ZTq8zdhtPuKwkI1wlkiPDQYB3qNoK4lER36DNoP1NqBhgx7mhLNlryO
 BM8CE/Mde+klAQdsk/b2pnDSHdOziqvAaiSM42vwdtr38LBQDg3mRw6AA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping? =F0=9F=99=82

I'm also CC'ing the x86 platform people into this, as I'm not sure
whether this problem is something more within their remit.

Best,
Alex

On Wed, 2022-06-29 at 10:43 +0100, Alex Dewar wrote:
> Hi,
>=20
> I'm running Linux 5.18.7 on an HP Elite Dragonfly G2 laptop, which
> seems
> to use the i8042 driver. Mostly things seem to work (including
> hotkeys)
> except that the increase/decrease brightness keys instead send the
> "mic
> mute" keycode. (The *actual* mic mute key works fine.)
>=20
> Any ideas? Do we need to add a quirk?
>=20
> Best,
> Alex

