Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFB8482DF2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 06:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiACFCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 00:02:01 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58933 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229798AbiACFCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 00:02:01 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 89A2F5C00CF;
        Mon,  3 Jan 2022 00:02:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 03 Jan 2022 00:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=aWpRUtqkhfwjQ
        Nuu0fj1GCDAGVOQI3zf2uNEDVscA6E=; b=dwp20hTiOd5WxzTAfIBBZpsermCHv
        c94esFRROgEANow1uaiNf+qU+QA3+rM2eJR7F+gUdPhfYw0MiC2Cq9sHSdnHDMoE
        h1Iyip0k0pE8bf5jVKspyDlIbL5EDOpPwJOxO1WtIOsm4/ugmaPdd6QCCjSNtvDi
        Ch8ZsxcWHorQP+d6UAy5PBzwdrKLQkG3ppR5MHIM2hEJuWXF44tNO1LU7ZNnXmwF
        MX4P7QAdZa2CR2BxMmhlBzqFhWeOemPsFx/QSPiTn8i34AAfJXPFymSq0ij7NN3Q
        VQ27MoDLx8u9BKqlYe2r2gjsPggycsffbsJomy8nnuD2jpef437piAMeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=aWpRUtqkhfwjQNuu0fj1GCDAGVOQI3zf2uNEDVscA6E=; b=PqvifSnW
        hD2g85qzK8pM6SH4eC7vP1Nk1RZW6IBA0nOoCxMK5k2ll2SL7SuW8/fwGKPN5qct
        BPwTT2kCrEF+xxyU8vAP2blAz1iX3Yi9DdJy3ohtFGhe8LYgMkVIVh8Kjz6w2Qc4
        UdeVDdF8PjDEB6s7dBg+Vf5tt4JrsgECrlgsxoK6Kgmsu3uLW+yFRdGClsVnZG37
        4yFeLtFPrklNsoZ7T9fzXX4Souxr3sLgcfz3WOJ7beSkvj4e61VuvUVtVtC9DUtZ
        i2y6/dGqWkptphmnRhNs774ukqB//cRUQyP4SXw1CS6IuCFik86BsayGAz4ImOeM
        v4NZhZbtohsYcw==
X-ME-Sender: <xms:SIPSYVyjYniAcMCqoF3FWhJ7dGAJuWe_faJ8ZQYfxy4CaAYCHAPYWw>
    <xme:SIPSYVRSiokHFk7zYFneW2rZtnO2MJJOffRyCaxe84OhpLX5D1AFpInLUNMSVsgHs
    MNj3t_7rSCoXqdX2g>
X-ME-Received: <xmr:SIPSYfXdrIroYns8KcaHyZz8Itz9xR7PAS9kD6cdts7UZehZZ2m7oghmWSVw8SRSE-5P9lsGhexYms1JLoVdAioExdkHcZrkkbsA9nkXAj5TAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudeftddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgkeduleekhfetvefhge
    fgvdegfeejfefguedvuddthffggffhhedtueeuteefieenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:SIPSYXgLxLPqB-02sRWIY_QUhPr2KSBEQwH4r_M3yt8zc-sq9DV5-w>
    <xmx:SIPSYXB2qosy3AEq6aYpPJoteehgkQ9td1jkOY7CLsmszyZABcFblw>
    <xmx:SIPSYQKqI25xuScygGhhWkZiBYT0J3Akyj_ZPSvAkH5_-j8Xrj4JQQ>
    <xmx:SIPSYS4jr23l0dzWA9DadQrEwIdJ4CbqkaXjGNwtt0JMYfpWG8cWng>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jan 2022 00:01:57 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, giometti@enneenne.com,
        linux-kernel@vger.kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, thesven73@gmail.com, ojeda@kernel.org
Subject: [RFC char-misc-next 1/2] cdev: Add private pointer to struct cdev
Date:   Sun,  2 Jan 2022 21:01:39 -0800
Message-Id: <34157f5e8dbaa1063dd76608e1e57244305460e8.1641185192.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1641185192.git.dxu@dxuuu.xyz>
References: <cover.1641185192.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct cdev is a kobject managed struct, meaning kobject is ultimately
responsible for deciding when the object is freed. Because kobject uses
reference counts, it also means a cdev object isn't guaranteed to be
cleaned up with a call to cdev_del() -- the cleanup may occur later.

Unfortunately, this can result in subtle use-after-free bugs when struct
cdev is embedded in another struct, and the larger struct is freed
immediately after cdev_del(). For example:

    struct contains_cdev {
            struct cdev cdev;
    }

    void init(struct contains_cdev *cc) {
            cdev_init(&cc->cdev);
    }

    void cleanup(struct contains_cdev *cc) {
            cdev_del(&cc->cdev);
            kfree(cc);
    }

This kind of code can reliably trigger a KASAN splat with
CONFIG_KASAN=y and CONFIG_DEBUG_KOBJECT_RELEASE=y.

A fairly palatable workaround is replacing cdev_init() with cdev_alloc()
and storing a pointer instead. For example, this is totally fine:

    struct contains_cdev_ptr {
            struct cdev *cdev;
    }

    int init(struct contains_cdev_ptr *cc) {
            cc->cdev = cdev_alloc();
            if (!cc->cdev) {
                    return -ENOMEM;
            }

            return 0;
    }

    void cleanup(struct contains_cdev_ptr *cc) {
            cdev_del(cc->cdev);
            kfree(cc);
    }

The only downside from this workaround (other than the extra allocation)
is that container_of() upcasts no longer work. This is quite unfortunate
for any code that implements struct file_operations and wants to store
extra data with a struct cdev. With cdev_alloc() pointer, it's no longer
possible to do something like:

    struct contains_cdev *cc = container_of(inode->i_cdev,
                                            struct contains_cdev,
                                            cdev);

Thus, I propose to add a void *private field to struct cdev so that
callers can store a pointer to the containing struct instead of using
container_of().

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/cdev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/cdev.h b/include/linux/cdev.h
index 0e8cd6293deb..0e674e900512 100644
--- a/include/linux/cdev.h
+++ b/include/linux/cdev.h
@@ -18,6 +18,7 @@ struct cdev {
 	struct list_head list;
 	dev_t dev;
 	unsigned int count;
+	void *private;
 } __randomize_layout;
 
 void cdev_init(struct cdev *, const struct file_operations *);
-- 
2.34.1

