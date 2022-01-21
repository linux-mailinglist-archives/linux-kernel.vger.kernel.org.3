Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4937495D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379800AbiAUJzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:55:04 -0500
Received: from mout.gmx.net ([212.227.17.20]:37849 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349731AbiAUJzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642758884;
        bh=35f9JoVpGFWU3xR7b8fBapZ696kkbYyLXKYQ9TlhbQ0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=N1yqIfVCwTO0YCam79KbUT0aCEJzRRx/3nP7nC2P6m1WPbmb6v6mEBgNsLn1IPgS1
         cW9EqAWDPYdi//D7yf/mJdjext+4YWbF2UaSuN4jJvh9odPEj66n9Orl75ybK4RO18
         qGEjhxnKRsqoTvDUvV/annQuMzZBngnyOmHX/xlo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.180.114]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAwXh-1n0ARh1Iev-00BLFZ; Fri, 21
 Jan 2022 10:54:44 +0100
Message-ID: <016269c1-cf56-04ca-91e8-02417f770af5@gmx.de>
Date:   Fri, 21 Jan 2022 10:53:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [GIT PULL] fbdev updates & fixes for v5.17-rc1
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, linux-fbdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
References: <Yeg11pHSqx29yg/T@ls3530>
 <CAKMK7uGeGBBvTGFyBxLwvTAxEWwXMS8U1rrYUb_7gbui-jV+KA@mail.gmail.com>
 <87fsph4fr2.fsf@intel.com> <Yep6te0wrK0ZQ8SB@google.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <Yep6te0wrK0ZQ8SB@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LTDA+u/QyLx5NLlZkZXwdyMGBJyxMIR1SiGWjtUH2ssBeCA3JEf
 lSMTThofRjaRuLiWD7LNNj53q2xyYYyji2BNkoxAuqBG8yB5C9U65uyCXVA3KLvvXQY0Il8
 GkCzoeFGSwCy50CN7s9IxPdTFfW/4JgvLkBtdLaKxWTxz9RjGPCqxMU1wmQpQ87eCf/sBaY
 fT3Tqw1e5/6qSK7HXX8+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+nLVNU0ON8o=:B9Nl8iHgEB9RYlXIRbJ63S
 oL9OMBLJdS9JllkJfDW5qViDQgsG13qyVn/E+Z9X8MaqTWiDWu9ddu2L/ELw0iDtMtY/5ODhj
 ggbLja/t6U95CsG60alXJXPweFS9CBHNRxF75jVZ1X52wLk014lqZwHrbN5uhgym5s/W41VAC
 eHkycx9cIN8yjU6zz9CulG/RvgM1E66HefogPnqPMiGEgAz/oRZUM8DxrZEzaIUnSFt7392BQ
 e6eONpASMYUP/nY3PwhNwAYE7p6CJ3Di3f3CQVQZ07+CIZLCCuHBqhqU2vYs+o0QBFoPrdy8g
 zf1rTc1Q9/s/7fsmcxyOFnNvKhk3zqPBB/BZImNYszzeH839cFUwLR/LBHdqlIGVO8AhkmIpd
 hZ/xyuPYXsNd04gaI3ZnzYFH70alLk5+DqLSLnCNLFLZE1Pt9zeAw36BUeiluIC8AHZLaJf/+
 jkWPbazb2Zi9ec/umawieb5Tqh3sH7GutJ//GzPaxc2ilTu3daNkZEYJzyB5vumh214C6hsy5
 SFp1G76zyQ5lq5Ec1xbTOHSljTS9STJZbmzhZdYW22KmQrpgWMEtaZNcXcMZ58S5rl91zjUIH
 whg3Zm+wOv/44bLmmtLQsaS2/jLi1TqFNVxV/FaI068FawoHVw4pQY7zMrs926aXSfAYabaDf
 V/Z4ogIqB2x/IPDdJJEQkADAAxkPSZuM2In/rrtKj2FNl6arGRtbeG4kfCSMQYGf2u9IOeWpe
 VrcYuKtIgKrBE0qZRJpfpNfSzLAGoni+YdMY2hyyxlRL0d5L5pIfKWMvMohccz1fUi2m7Cfyk
 7WZxXcLaENmp3gUuSXQ2FuHK2VtOGr3ql6sYSQtLACMSZENsxjwaF0eZEzv1IAHyH8IeEKtrb
 TXBqkwW5fRkarOorK9o7LO4K955CplLRGWH5VNxgOeSbuQnGBdx85nC2VMTLXihRWc6j8m3/d
 U8FcfZft1aomGcXLoJ90u88XLYyfhG1bUWri3w7a7dBwmrCuaYUnvm5Pvr6X5TDuThzp8Slf2
 lgRHVhC8KoNWe/9HwzXjwFnzVrnAoQLIHtJ81d7eH2GIJXUtoZzWhvoxTOMmL/bGX4t2W1ETB
 igJgMsdwliHZy4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/22 10:19, Lee Jones wrote:
> On Fri, 21 Jan 2022, Jani Nikula wrote:
>
>> On Fri, 21 Jan 2022, Daniel Vetter <daniel@ffwll.ch> wrote:
>>> On Wed, Jan 19, 2022 at 5:02 PM Helge Deller <deller@gmx.de> wrote:
>>>> A first bunch of updates and fixes for the following fbdev & backligh=
t drivers:
>>>> ocfb, aty128fb, mb862xx, omapfb, qcom-wled, dt-bindings, hyperv_fb,
>>>> lm3630a_bl, omap2, controlfb, matroxfb
>>>>
>>>> Nothing really important, mostly cleanups, const conversions, added n=
ull
>>>> pointer/boundary checks and build fixes.
>>>>
>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>
>>> Not sure whether Linus missed this or just wanted to let the
>>> discussion settle first. But since this is all random patches for
>>> drivers that many distros don't even enable anymore there's no issues
>>> here, and I very much welcome someone volunteering to pick these up.
>>> I'd expect there's a pile more since it's been 1-2 years since Bart
>>> took care of these and merged them consistently.
>>>
>>> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>> ...
>>
>>>>  drivers/video/backlight/lm3630a_bl.c                     |  1 -
>>>>  drivers/video/backlight/qcom-wled.c                      |  1 +
>>
>> Backlight changes usually go through the backlight tree.

Sorry, I didn't know yet.

> Yes, they do.  How were these applied to the DRM tree?

I did applied them.
Shall I drop them and you decide about them?
Next I round I'll take care not to pick backlight patches.

Helge


> I don't see any mails about them being applied:
>
>   Luca Weiss (2):
>         backlight: qcom-wled: Add PM6150L compatible
>
>   https://lore.kernel.org/all/20211229170358.2457006-2-luca.weiss@fairph=
one.com/
>
>   Xu Wang (2):
>         backlight: lm3630a_bl: Remove redundant 'flush_workqueue()' call=
s
>
>   https://lore.kernel.org/all/20220113084806.13822-1-vulab@iscas.ac.cn/
>

