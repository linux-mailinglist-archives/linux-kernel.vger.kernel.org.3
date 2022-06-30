Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06765561647
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiF3J0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiF3J0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:26:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB7F3B3CC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:26:43 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.24.177.228])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DE5D26601946;
        Thu, 30 Jun 2022 10:26:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656581202;
        bh=kgvbQ/RPxk3m9PIguKbQXABiodoSZSGgpg3QGHI6ZHs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nSRDDSOI05ZIloywcqbon/WHG0TI9jQ04E4H26O6s/bD2TAVLlyNHW3JE7xFs8z+/
         4Ljq8pEuj7GIpRvmDERcGvuccetB/i70EMapWljVDzqys3Cu17MATc7t3hfpOR28Sf
         uE+LsFiNK0QUxQ61pZpGxnqARFg3HMadnlWT+YW3AyydEIy+XM9RDsMA+sFurJzz31
         JsHcjR4FS+DMr5HtCww/tza7QRGiBCMonJHCMt0w0YRWv21FfY6WsKWfFcuNTb8boZ
         mXizubMlh0GIk/KuokJOwPd0vX8qKep8LTzoU8HKGqTY+ifIpMvyCY8QnK1IjH8MRk
         i6Gv2iiZoM4cA==
Message-ID: <9be2090f-586d-7b7b-f93b-6b10cb5bb19f@collabora.com>
Date:   Thu, 30 Jun 2022 12:26:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] scripts/tags.sh: Include tools directory in tags
 generation
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Vipin Sharma <vipinsh@google.com>, rkovhaev@gmail.com,
        zackary.liu.pro@gmail.com, ripxorip@gmail.com,
        masahiroy@kernel.org, xujialu@vimux.org,
        "drjones@redhat.com" <drjones@redhat.com>, dmatlack@google.com,
        linux-kernel@vger.kernel.org
References: <20220618005457.2379324-1-vipinsh@google.com>
 <CAHVum0euKMV+rCLXMQ4NuDAqowyeCkO1LheSafR2tm=R4aUfJw@mail.gmail.com>
 <YrqaKpdVDl8DBl4g@kroah.com>
 <CAHVum0f=_7kh_OrOqiTH=UZuvr3ZbxNcZeUSbT66x5r0q2XEgQ@mail.gmail.com>
 <b1b5666a-67a7-469c-d6c7-e585cf59c632@collabora.com>
 <Yr1F0xKlrFsuJWWA@kroah.com>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <Yr1F0xKlrFsuJWWA@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 6/30/22 09:42, Greg KH wrote:
> On Thu, Jun 30, 2022 at 01:54:00AM +0300, Cristian Ciocaltea wrote:
>>
>> On 6/30/22 01:18, Vipin Sharma wrote:
>>> On Mon, Jun 27, 2022 at 11:05 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> On Mon, Jun 27, 2022 at 10:47:35AM -0700, Vipin Sharma wrote:
>>>>> On Fri, Jun 17, 2022 at 5:55 PM Vipin Sharma <vipinsh@google.com> wrote:
>>>>>>
>>>>>> Add tools directory in generating tags and quiet the "No such file or
>>>>>> directory" warnings.
>>>>>>
>>>>>> It reverts the changes introduced in commit 162343a876f1
>>>>>> ("scripts/tags.sh: exclude tools directory from tags generation") while
>>>>>> maintainig the original intent of the patch to get rid of the warnings.
>>>>>> This allows the root level cscope files to include tools source code
>>>>>> besides kernel and a single place to browse the code for both.
>>>>>>
>>>>>> Signed-off-by: Vipin Sharma <vipinsh@google.com>
>>>>>> ---
>>>>>>
>>>>>> I have found myself many times to browse tools and other part of the
>>>>>> kernel code together. Excluding tools from the root level cscope makes
>>>>>> it difficult to efficiently move between files and find user api
>>>>>> definitions.
>>>>>>
>>>>>> Root cause of these warning is due to generated .cmd files which use
>>>>>> relative paths in some files, I am not sure how to make them absolute
>>>>>> file paths which can satisfy realpath warnings. Also, not sure if those
>>>>>> warnings are helpful and should be kept. Passing "-q" to realpath seems
>>>>>> easier solution. Please, let me know if there is a better alternative.
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>>    scripts/tags.sh | 9 +--------
>>>>>>    1 file changed, 1 insertion(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/scripts/tags.sh b/scripts/tags.sh
>>>>>> index 01fab3d4f90b5..e137cf15aae9d 100755
>>>>>> --- a/scripts/tags.sh
>>>>>> +++ b/scripts/tags.sh
>>>>>> @@ -25,13 +25,6 @@ else
>>>>>>           tree=${srctree}/
>>>>>>    fi
>>>>>>
>>>>>> -# ignore userspace tools
>>>>>> -if [ -n "$COMPILED_SOURCE" ]; then
>>>>>> -       ignore="$ignore ( -path ./tools ) -prune -o"
>>>>>> -else
>>>>>> -       ignore="$ignore ( -path ${tree}tools ) -prune -o"
>>>>>> -fi
>>>>>> -
>>>>>>    # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
>>>>>>    if [ "${ALLSOURCE_ARCHS}" = "" ]; then
>>>>>>           ALLSOURCE_ARCHS=${SRCARCH}
>>>>>> @@ -100,7 +93,7 @@ all_compiled_sources()
>>>>>>                   find $ignore -name "*.cmd" -exec \
>>>>>>                           grep -Poh '(?(?=^source_.* \K).*|(?=^  \K\S).*(?= \\))' {} \+ |
>>>>>>                   awk '!a[$0]++'
>>>>>> -       } | xargs realpath -es $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) |
>>>>>> +       } | xargs realpath -esq $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) |
>>>>>>           sort -u
>>>>>>    }
>>>>>>
>>>>>> --
>>>>>> 2.37.0.rc0.104.g0611611a94-goog
>>>>>>
>>>>>
>>>>> Hi Greg,
>>>>>
>>>>> Any update on the patch?
>>>>
>>>> Nope!
>>>>
>>>> I don't really think we should add back in the tools to this, as if you
>>>> want to search them, then can't you just generate the needed tags for
>>>> the tools directory?
>>>>
>>>
>>> Some folders in the tools directory do provide cscope rules. However,
>>> those tags can only be used when I open the vim in those directories.
>>> For example, if I am writing a KVM selftest and I want to explore code
>>> related to certain ioctl in kernel as well as some code in KVM
>>> selftest library, I cannot use two cscope files (one in the kernel
>>> root dir and another in tools/testing/selftests/kvm) in a single VIM
>>> instance. It starts having issues with the file paths. If the root
>>> level cscope file includes tools directory then all of the tags will
>>> be at one place and makes it very easy to browse tools code along with
>>> the rest of the kernel.
>>>
>>>> But as I don't even use this script ever, it feels odd for me to be the
>>>> one "owning" it, so it would be great if others could chime in who
>>>> actually use it.
>>>>
>>
>> Since the tools directory has been excluded just to get rid of those
>> warnings, I think there is no obvious reason to not add it back - at least
>> the use case described above is perfectly valid.
> 
> So is that an "Acked-by:"?

Acked-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
