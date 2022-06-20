Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E895523B0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245207AbiFTSQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243978AbiFTSQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:16:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC96F19C1F;
        Mon, 20 Jun 2022 11:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655748957;
        bh=IRsReQcPvKjGuOiWZ/naJXtB5sl9AWyUBgzpYTxhbu4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MpChZBAWOnKxGAjsdfSCjFh/gS+GTAFDKiwYXwYJAlHPLUPaZG6FHf3igR/s9RvC0
         JmkGFg2SzjQNrBff06GdWIu9DFQjbxDT6i9M3n5t3dgNSZTHH+rxsTE6i07afeLq0p
         KPBapCFQaZDQpD1B14JLAelnUzGIrkOc/6PhXWx0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.174.149]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VDE-1nbB703cd8-016vo0; Mon, 20
 Jun 2022 20:15:56 +0200
Message-ID: <4bf0f587-e03f-60bb-806d-383cdab8f67a@gmx.de>
Date:   Mon, 20 Jun 2022 20:15:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] video: fbdev: offb: Include missing
 linux/platform_device.h
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, manoj@linux.ibm.com,
        mrochs@linux.ibm.com, ukrishn@linux.ibm.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, tzimmermann@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <a1dfa936043eeed715e8cda7f8690fe553ba7c1a.1654966253.git.christophe.leroy@csgroup.eu>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <a1dfa936043eeed715e8cda7f8690fe553ba7c1a.1654966253.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oJ9D9uGth3QBUylu+JFhLcVTIwUeAyZlFlYU4v/OPaS0ZpMihid
 tFsd2Tanp1YkXXsADmZD7gloGpa+E8c77bFVGDTOIbSoHVGGXqjDnhlG9X2kTmyAlcnkiUl
 YaAKGLHLr/7Cwe1Lwdry13RBpDCqRwRDdC+6HA3J7Kwgih+MFmqOSJeeQQotfiAjelWovxP
 NrTUJ0YmY4qRCYYTkWkIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3vwy0K/BsAQ=:mVmzG3FTCEVF3YJX5VmLFq
 Kbv0n9xBZ6oUg98dEQxL4XTvzFNHHEGeN3hcL6indwAgqvhjioXSbhbKWULn00ypejKFc1iXd
 JOslbeYH6NjU8rKb0MOlREPzpm3pqldRQiGRb/oOkVvf11r6NeKbHvT5Ae49+2NT5r5gXGpRS
 eWlFFRvp/ZrxeWFs85bNA241DQbVyAEWidEJXm9VoLHEx9iEm+G/Je3W1TvgHUJEyE9cxZ3NX
 3zLLLHjPv0Llp5WKUlkxtPMVqsOwMRF9lA96B0oPljvv/u0yfM7BJEoasOA+b60Wt9c6QVX37
 QhuQNtCKZD38TlS5W3KzUCz2HqFl8hSFaZx1qpL3mjJlcqlvvc234e7nparz+irI/oyK9dcWM
 ZetxeGVX79OIMe8HkkKVu1XZTHU0KwCdMHLgMo5XX4JflfFMifb1v1V2G+oO666w7H20jAend
 I8p7k78nHtJNJ+7pf/3fUF28i0tNq6gzXwFVffQzK7lmML9K/dfQJJ+uL4nt4yo3ba52/awdR
 yH8ge1cIV9TSL4D9wyXN02o1d++3z57DXeW/qZXGzve0MQyhLWLafNsa9jvpzAK85hcXwzaNl
 ieRnoqKRsknQDnbVwPPoIALxDUhUYu0kwIZC+nsX6CiTxjRfBKeDH0/WWuUjG1JQzu2kBcJ09
 bdiuWvYdpgDF+bute0DrVmYipy4qLrBo+1xsP5SVLeZYa4LgQvPTFbz2PfOsulplzlYxeZ4/Y
 hlW2ILy5JIyow4X1B5T4uryx4ZAPsJuWVlsD31x6HqOLtqkc49D2nYiIaCN8yN5iO76fdtsHh
 SuZ7lMlmo3UmIVLzhh8dy/TJvIJ91eW+jhA3hwV6fqnIpzTuuaXiNvozdUzfeSdws/2kfanWx
 k8Rc6XE8UTjCH/8nv8IR4kBcd+W3aTJCTXY/ocolP5FuGgw/RJAuLetxI+lpCtU1es/cJmgIi
 i/duuVuvcwrWKTHqLJNNTizAP8Cpm9VTyZlmn0C+FpT0vu3CAFMtFSshelmvdS5OKdxI/C+00
 Gnv4LClT5oFI0QNeO8MI6jnR51W6lHXSXswDav1aKaHZwiAzNIlYuAzEsKrhho5aJ5t2IdziY
 62A5GzemI0vJpp5H5uncv1hbDRM7FWxSZquInJjY6wCVwRD8+5eLTsdoA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/22 18:50, Christophe Leroy wrote:
> A lot of drivers were getting platform and of headers
> indirectly via headers like asm/pci.h or asm/prom.h
>
> Most of them were fixed during 5.19 cycle but a newissue was
> introduced by commit 52b1b46c39ae ("of: Create platform devices
> for OF framebuffers")
>
> Include missing platform_device.h to allow cleaning asm/pci.h
>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 52b1b46c39ae ("of: Create platform devices for OF framebuffers")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Helge Deller <deller@gmx.de>

I assume you take this through the linuxppc git tree?

Helge

> ---
>  drivers/video/fbdev/offb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
> index b1acb1ebebe9..91001990e351 100644
> --- a/drivers/video/fbdev/offb.c
> +++ b/drivers/video/fbdev/offb.c
> @@ -26,6 +26,7 @@
>  #include <linux/init.h>
>  #include <linux/ioport.h>
>  #include <linux/pci.h>
> +#include <linux/platform_device.h>
>  #include <asm/io.h>
>
>  #ifdef CONFIG_PPC32

