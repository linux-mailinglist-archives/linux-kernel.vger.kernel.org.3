Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B5A491162
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 22:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243332AbiAQVmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 16:42:24 -0500
Received: from mout.gmx.net ([212.227.15.19]:33383 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237515AbiAQVmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 16:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642455732;
        bh=CjO3Hio2OwEz3aLo79EY9u6+106RoCFGduZbE4yheTs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=gALf5YeO661+wEDU/erTMhRoSmqHHshcrKiDy85NxOpCod8H3IgYNmmevWgf68Smi
         APVc/5id2erWr1mS9B7fKGUczb2WjvvlhRUSpqIOCt7rWZfBpaJAWI27cnJh5RdadG
         8lMLoyqw3ZytrZVrDSbM4ZRWt+w2mkAqoHBJilxQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.167.237]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Vi-1mGMdY2Jui-016Qb2; Mon, 17
 Jan 2022 22:42:12 +0100
Message-ID: <c86bd360-a3d3-9aba-cd98-d1458b301787@gmx.de>
Date:   Mon, 17 Jan 2022 22:41:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: linux-next: Fixes tag needs some work in the fbdev tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Z. Liu" <liuzx@knownsec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220118083336.25b0bcd6@canb.auug.org.au>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220118083336.25b0bcd6@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pfFYL1ylQwNolxj51a/ex+/2d5RyUzhFaXO5cB2Ano5AQn030KM
 yY2w5Q24JkrKGnhLlL5i+M8SLC9iu/2xd+ckRByeoF4HqvAjaVltYqVDEdI7ntFmXPXkua/
 VWZE/2E0rpHFoLJrF9fxt8tnagZXdYHPfo/vJXN7fkw+TzL9N5zaoSsFObsYOcY7kG53gyc
 clQK5VIxDfx/EIpJU3h+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SHg2tCboBbc=:EGyRHHp3Uo/LowcHp10y/F
 C3ZxlsCGTToi3oWB+/7lGLmYfDd5wQ98bYhvyg6JleK9MQw6qgOY8BSAZE+qyxoDb05WQAhTB
 HJ0qxxrRd1ZhkgoiIeRxkbr/KVbxWv2+Os1MVkHSzl7Xe7wqNroiF7X7WRX6NgTG8vRFPKBod
 o4XAb42twHxGsAkqyECTP+OE8+PWpr9nXq0ztMhKUMvEMqntyQHmOLkpRSkR/7Hx/fDLG4ldv
 GeKAKucs8NuDdFtMiSbIfhbTY5Sm+HOeEaapK4gkp21BdCFODngcGYgv4yeTTOTxer3lL85Ot
 4rMy8b9wsZ5tDx+PyaA2lkIvVZX5vlQP8iOd8yKQYVhFYQqlk9/amOeucoctq+VO8AuShfuNu
 GjvXdINEyygQJWBW3elkPGEem6/6Ub4RMgHEzzhyam28V2QPAaE9za2y98ZcTeXulfQ6Z5+lr
 ze+NjrUuDB6uttajMRlGckuE5Veqw5yrbk6epgyok/gervvBJsn9YRxwZaGImkmrDBJxTPO87
 k3iZh34osOWeJdAZFwcmL1aRID6vOcQO1sj8atmM0WpbJWj7LOYYaucMXz6JuF1xkhv6EYFQb
 aOtZ6AJ7zcb7bl0B1/oZBcOu3hjmdnsr3sdSD7yfQCIvMgxhFNcw+J+xJVi0X+EpgpVExRG0n
 g3blrsX46zml1fOT0YgIdxSk9fSUcsd0KfHFPa+hHOJDwPuUqzJW0uFUm9276fS27eTmzPdFs
 oXPo9aRB+j8S+oBg4AbAh/UBFHFlGxIuRGU7yN/D9zVQe5So31PTXC4VdgUhkb1Vzzorx5uTT
 4oD/RAZ5G+/ZDMADHPrRMk878YhIENLng5ytIok49opflr7HK4C0upKw+AX6WFqXac2D9gsmC
 DG0pXIciKXxNy1RSnrva+5PvGj/mAbRxnceFTUlTkCwGrIgFYWlIaYjd5bEitKd/5bHupAckn
 fKcI68JwsJ+cY6Or+x7YOYvlqik9+LrT0A4fXSlwJ9O4Tk7N9tMoh4yf6VKWWMg9CGIxoY8QG
 Di2uFRzlwGoVMHUT6MlZNJieNCF1khmr3mj9a1gVSgjC2ylXSeh4v52Nh/d7v0w88/geDDy+D
 G5I2pV+Tnogskk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 22:33, Stephen Rothwell wrote:
> Hi all,
>
> In commit
>
>   a274f635669a ("matroxfb: set maxvram of vbG200eW to the same as vbG200=
 to avoid black screen")
>
> Fixes tag
>
>   Fixes: 1be60bd66d54 ("matroxfb: add Matrox MGA-G200eW board support")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Maybe you meant
>
> Fixes: 11be60bd66d5 ("matroxfb: add Matrox MGA-G200eW board support")

Yes.
Fixed up now.

Thanks!
Helge
