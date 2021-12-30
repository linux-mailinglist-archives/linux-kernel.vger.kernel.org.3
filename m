Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D5E481CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 15:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239922AbhL3OPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 09:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239895AbhL3OPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 09:15:06 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8924DC061574;
        Thu, 30 Dec 2021 06:15:05 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id j11so52971240lfg.3;
        Thu, 30 Dec 2021 06:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AyX/x7WeCJ1rGnhhYHPa05Mi1k4ufPsoH8p2YYLDsHY=;
        b=J/9CTJGtGVHWZo494R1vS6mUFDwKYW0telpmKTOgr5cD+JlvVj+QhQU4V0uTfIZwYe
         /aEnGf/ZAUl2gFaFkmgCzdalDa8vhuwsHw89CgcWR7SJDuU/Bcba2XNl1n3Kx8z1ZWl5
         2ZSh4a3isbzjlEDJN1mrQt+lfiSK9KCmw2hTdTuKQD5tkJkltEHH03QM/RFyxpKwLzNT
         SzongPQia4d7MDNJpEY95MdpWmfkC+7REAiDXdHDhCEwoFkkXXFo9o0IKOF2Ld7+NX/d
         Cb/H7cTBFBXlx51eqlJqShndIqO0r1qv3DPM33lOWAl8WeCVoAmc9w8+nGqS+i5XfHWC
         FF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AyX/x7WeCJ1rGnhhYHPa05Mi1k4ufPsoH8p2YYLDsHY=;
        b=46tSESQftkLwGq4c8CQ2Ct42SLiGgNbVNPinhmekpykmWnYAtQgftMFe97slnAcN9w
         TCq6ti7372c7IDAtI31Gy1nFuMHTNfmRyqg4UmDRUXSLDtacpy1AB4iHJ2H5FCySmP2h
         +ZnZyEqC85X91v3eqjgb+J6CQG/7bxA00Kc0qqa3OSabsbjioGmubX0YcFFTwCJpBA7G
         oH0bvCau4AOpEDW/bn+axJFUfD3j642nTn7WPcCJ9zp35I4NdxYGTF10zZTiuOmydEjT
         f7HZr+gH/2HTF1kHthXvOFlexTg8YMUlM2KwnOJbrKLoUUz9Zu9QS/CwRX8EadW1Rm63
         GM6Q==
X-Gm-Message-State: AOAM5318iN1fro6J9FIFCcsSrdB/QsaeMuQoKME6XXs92M6TB6Eou/7w
        o8DWOhxRhC9c1Mh1qiRhTVRDRLEmudeF0nmGuk+y07SpwCk=
X-Google-Smtp-Source: ABdhPJzEu1J+3OhZ37dG2jprpEv4TQEXwD/mftpOsBat7vCcvqspy8cwq853xARWjhUM9Y7TIhseAmDt26tG/lBIPhk=
X-Received: by 2002:ac2:5d64:: with SMTP id h4mr3467669lft.390.1640873703672;
 Thu, 30 Dec 2021 06:15:03 -0800 (PST)
MIME-Version: 1.0
References: <CAKXUXMxh=QK4C5OfLL1wSvoGFJZ8U+EhSr5dy9ddExtVhAdU-Q@mail.gmail.com>
In-Reply-To: <CAKXUXMxh=QK4C5OfLL1wSvoGFJZ8U+EhSr5dy9ddExtVhAdU-Q@mail.gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Thu, 30 Dec 2021 23:14:51 +0900
Message-ID: <CAKFNMom0tzQy7ygcburkhOHSoVCO+d1_VPG24ofn=Y+KAO-4Jw@mail.gmail.com>
Subject: Re: References to non-existing configs in the NILFS2 FILESYSTEM
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 30, 2021 at 9:59 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Dear Ryusuke Konishi-san,
>
>
> The script ./scripts/checkkconfigsymbols.py identifies references to
> non-existing configs in the NILFS2 FILESYSTEM:
>
> NILFS_POSIX_ACL
> Referencing files: fs/nilfs2/nilfs.h
>
> NILFS_XATTR
> Referencing files: fs/nilfs2/nilfs.h, fs/nilfs2/super.c
>
> I assume this filesystem support is simply not yet developed to
> support those two configs fully, and these code blocks are just some
> first steps in that direction, but are currently just intended to be
> dead code in the repository. If you do not see this support to be
> added in the future, you could also just delete these ifdef blocks and
> these references to non-existing configs.
>
> This is just to share this information with you; there is no need for
> further action.
>
>
> Best regards,
>
> Lukas

Thank you for the feedback on the check script warnings.
I will put the decision on hold, however, I recognized it.

Thanks,
Ryusuke Konishi
