Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79ED149EE05
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 23:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240706AbiA0WWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 17:22:20 -0500
Received: from cmfo-0001.xspmail.jp ([202.238.198.178]:27670 "EHLO
        cmfo-0001.xspmail.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238336AbiA0WWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 17:22:19 -0500
X-Greylist: delayed 14403 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jan 2022 17:22:19 EST
Received: from cmo-0000.xspmail.jp ([202.238.198.57])
        by cmfo with ESMTP
        id D9PTnsOff9M5xD9PTnvwNv; Fri, 28 Jan 2022 03:22:15 +0900
Received: from cmr-0002.xspmail.jp ([202.238.198.119])
        by cmo with ESMTP
        id D9PSnaGKiwQRRD9PSnU7Lm; Fri, 28 Jan 2022 03:22:14 +0900
Received: from elitebook830 ([IPv6:2409:12:b80:1600:39e1:fc73:9e8c:f6df])
        by cmr with ESMTPA
        id D9PRnyD5QzwgpD9PSnPJAH; Fri, 28 Jan 2022 03:22:14
 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iijmio-mail.jp;
        s=x01; t=1643307734; i=henrich@iijmio-mail.jp;
        bh=i398RoUxo97xU4F5V5eK9kNXl+s5I63U2+LkDLoZvvE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=E8TuJOXfjYavstwxCrAVe3ZVfboYfDz1p7UI1UE7e5S5KH+nkzpB/+4DFmVvOpHUF
         x8J9biXKLf5eVndbR005BAMb/h6mhk/k8ce0juxiM7+uZEy+3UB1jdX6yeCKN3/mRN
         13rCwICNzCF3DEPEr/peGlfhNUCKiT1x9FAVKUMdbgezbpkR1VFoH4FjhpNm1flJNq
         +01jfeGDeilv2TMqPQ9nsZiMQxq4y9TumeaxaJ/JDgKyBXeBBf9ij6J1Uu7fNo+Ua0
         /eTJ42iXHV+1BddGy9XQKsXnxR92roOVJ7xPJNhGrobUXgZy1GHE7wsPD/lC42i26W
         g2+uyd+yiuNzA==
Date:   Fri, 28 Jan 2022 03:22:13 +0900
From:   Hideki Yamane <henrich@iijmio-mail.jp>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] firmware: Add ZSTD-compressed file support
Message-Id: <20220128032213.c93b56aa2ea1c77e34b28290@iijmio-mail.jp>
In-Reply-To: <YBGeXDTEy8myghot@kroah.com>
References: <20210127154939.13288-1-tiwai@suse.de>
        <YBGeXDTEy8myghot@kroah.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 18:09:48 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote: > 
> > Currently, I have no idea whether any distro would use ZSTD files for
> > firmware files in near future, though.  That's the reason of this
> > patch set being an RFC for now.
> 
> Looks sane enough to me, if we have a real user, I see no reason why to
> not merge this.

 Just curious, any progress for this?

-- 
Hideki Yamane <henrich@iijmio-mail.jp>
