Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC29493EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356299AbiASRFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243725AbiASRFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:05:36 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54715C061574;
        Wed, 19 Jan 2022 09:05:36 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id v7so2588810qtw.13;
        Wed, 19 Jan 2022 09:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xNn75qzGd+nXVzzF0p1+GWTBBuJh8tB0QC9sPPOPoXA=;
        b=IUYiImLFgLU78AOUTXR831cGaiyP81q9NSSOZZ2cipZINeZmQ7JFs2NrHUtNbsGInd
         H72z4Zvwto68QC257DI0lH2u/K3EraaRqvvA3mNGoePTEcF914PBsKhegWksOIpyXqik
         fibHVhqhymWh3xVp37VLMJnjrDfUURNLDt8AjRGEEWMASo8lqK7k2RmQZL/IObhdg6u8
         0Iw63nmaJbYM3dArTVMzacz/A27IOh4xyJ+9Lg5tKxWRz9rXnnojzoIl3v+nfVXgXfyH
         /sg8hLcUt/mdwTF+6pd01gU60sUN0OFiPFlSiqlgaCNajcEHo6MZkRwWQDc5VHVRAvKg
         MKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xNn75qzGd+nXVzzF0p1+GWTBBuJh8tB0QC9sPPOPoXA=;
        b=pKFmM9O1uoVFN9mksdqPieT6lMmQU6SIsE3gINsI8gk6DvvFvvqCbpqp2zp+Xo07Eb
         Q66HXm3+cyNAEtsYYVwNjszXigiqEEmnJb8CRt0U2AGZUXei2oEfH8JDpRRJ5A7KIjv9
         71513NLALg4y3cc2TN3gJF70SoxteJAUipcYzop6Afe1KA0SznHg2ITZHtXgHItKHUqG
         YxOPiycyTK+M3n4yOXknp+7YCkz6Hu/w0WRXP1G+67UOXxTQjRBadRahTtmGwkIRg4tR
         OAXIuiOqcLE+5FNV+nsojkGp2s4Z7eR6szcfLL98tL0omC79FimkB+4ZNlbb3B0QsuRv
         k2dQ==
X-Gm-Message-State: AOAM533AzacmdpodiXhMXOkFbgUtDjnvdQOzvAuhk2NvIN8Y59Su7O9M
        9IDvOIghlU9vLYPyxboGWYos9Ed36wk=
X-Google-Smtp-Source: ABdhPJy47q2V1IyLH6u81sprn0wRz8eHrH45ho8G02+/oBKHeAgc+IZMpN6H2VYHLkeCgYbpB45mDQ==
X-Received: by 2002:a05:622a:343:: with SMTP id r3mr1255030qtw.443.1642611935363;
        Wed, 19 Jan 2022 09:05:35 -0800 (PST)
Received: from vps.qemfd.net (vps.qemfd.net. [173.230.130.29])
        by smtp.gmail.com with ESMTPSA id z2sm7521qtj.62.2022.01.19.09.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 09:05:34 -0800 (PST)
Received: from schwarzgerat.orthanc (schwarzgerat.danknet [192.168.128.2])
        by vps.qemfd.net (Postfix) with ESMTP id 575F82B2D5;
        Wed, 19 Jan 2022 12:05:34 -0500 (EST)
Received: by schwarzgerat.orthanc (Postfix, from userid 1000)
        id 4C92460032B; Wed, 19 Jan 2022 12:05:34 -0500 (EST)
Date:   Wed, 19 Jan 2022 12:05:34 -0500
From:   nick black <dankamongmen@gmail.com>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] console_codes.4: ffix
Message-ID: <YehE3p7es9/4wBuM@schwarzgerat.orthanc>
References: <YeEc2pYvKEckcAmv@schwarzgerat.orthanc>
 <98d87c52-da33-9ee4-b9df-253c8ae8e093@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98d87c52-da33-9ee4-b9df-253c8ae8e093@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alejandro Colomar (man-pages) left as an exercise for the reader:
> As I understand it, it's there because CSI is not a CSI-prefixed sequence
> (i.e., you have to first document CSI itself, and then in a different list
> you can document sequences prefixed by CSI).
> So I'd say it belongs there.

except this is literally in the table named "ESC- but not
CSI-sequences". and it's not, by itself, a sequence. and it's
detailed in the "ECMA-48 CSI Sequences" section below.

so it is documented, near where it's relevant. IMHO.

if we're going to keep it, we ought add OSC to this section by
the same reasoning. i can do that and send a fresh patch, or you
can do it to my patch, or we can do with what i have.

> Maybe it should go into a separate subsection called "Operating system
> commands"?

well, there are only these few, and they are "ESC- but not CSI
sequences". i don't honestly think the average reader cares
whether something is a CSI or an OSC or linux-specific control
sequence, especially since there's really no user-relevant
reason as to why one is in any given group. but i can go ahead
and break this section out if you'd like.

put another way, some people might read the man page wanting to
know "how do i change a color". i can't imagine anyone ever
wanting to know "what are the various OSC-prefixed commands?"
that said, i'm happy to introduce the substructure if it gets
the formatting fixed =].

-- 
nick black -=- https://www.nick-black.com
to make an apple pie from scratch,
you need first invent a universe.
