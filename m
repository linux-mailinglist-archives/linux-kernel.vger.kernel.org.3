Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA7651FA8B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiEIK4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiEIK4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:56:11 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F04239B2C
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 03:52:16 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.94]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N3sye-1nwZfH1eoi-00zmO3; Mon, 09 May 2022 12:51:55 +0200
Message-ID: <02be1caf-1f17-7c81-4167-ade690cb6e41@i2se.com>
Date:   Mon, 9 May 2022 12:51:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] staging: vchiq_arm: get rid of global device
 structure
Content-Language: en-US
To:     Adrien Thierry <athierry@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220502183045.206519-1-athierry@redhat.com>
 <20220502183045.206519-3-athierry@redhat.com>
 <8483a250-da97-1875-4ea3-598f46ae96ce@i2se.com> <YnQTPmNAvpbQl5Ws@fedora>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <YnQTPmNAvpbQl5Ws@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:cQEfP+WKAagTTaWNIYaA0g3+6RiwmN+CXbxpj5WFv4ukO5e8j/8
 QBg9Sxtl08kbLIDV0Wx4CbYFlb/XKvLmUYhg7Rvm8hnGE9MCOja9dMGYxlAB8N9EveBEgAO
 njy/wlFPalpOIvDf58BpdqjCFSwMmqxD173W69Gqm5XwZllNYdShSxFvR7QkLl5qV0tcxxV
 JOlgGBVaNJs+TD6qLkiDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gps63oi8aLU=:BsZvN1PVCYlPgjPdjjM602
 I5eoAMluwhN/WTIz1ZTaf82mdnz3Cje/dp0hF4OyeWUZuTgJxlAlHTAWTIGu6LM1SM79IcUS6
 zFNLvVQFfWGvyJ4ZDAUiOT3OugiDDj7LQpdLOQRu3n7v9eB0HRdTalPWa8FS7fZF0I91lla3N
 RQoGxuvoaDRLwAx8z/UGuShLZU5eYf5vcCBPC7cjd8/LaWtAefgH2OdVYUbiu1b285VlegiGk
 O3X2RUgBRl14xZDR0mZ/pwwbxxQmPHRMy70wkiTeYsDnSRaYbDATjdIC1Zu0fd8GA1c73kdyQ
 TNh8FUcNgas36DTqbC9Ar5/+gVhIJW0aeWn5Fk/UWQ435MYpPP/kdk1mc4U5N0JCPM9NJDU6E
 R3i7t8QohuWu9nWq57QqTS1oTw3X8fbpmjagxuh0G1K5n3UKu0TMO1mnom4GaiVf+FFAbeRgH
 vZ7wj7S8CRdVgJ3GkDmclGyGerM9ZkoFml1TynrInnuGZ92OxMgAbV28aCuCh1sRjb3W6UqYA
 we6VQZdsSBapIcIaMXGDwssawUoxyQRAvQpqIzhdnKXD8srdy0rnAZ6qD9DpX/tLblFX3sdOB
 iRvpusrIg150lp1yRKaOjXGEcNOkw7eTJNj5K0aJICnJciEhMdUajo8xVeVWIN37KZtf6c4Y+
 eqJtPTsZHeTa7CbMjGy0TTJQBEwIHPBs7TcejBCKpBOCRjps5uD7eS3QVxRWXmC2VAJAI2rMh
 4CRIovzFmhTSVJiw
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrien,

Am 05.05.22 um 20:11 schrieb Adrien Thierry:
> Hi Stefan,
>
> Thanks for your feedback.
>
>> i understand the motivation, but could you please explain more in detail
>> why you decided to add vchiq_instance instead of device reference? I
>> think vchiq_instance is a more internal structure which should be
>> avoided in kernel consumers like bcm2835-audio or mmal.
> I used the vchiq_instance instead of the device reference because in order
> to get rid of the vchiq_states array (patch 3/3 [1]), I needed another way
> to access the vchiq_state in the 'handle_to_service' function. So I passed
> the vchiq_instance to it (I could also have passed the state directly
> instead of the instance), and this propagated in the caller chain all the
> way up to 'vchiq_bulk_transmit' and friends which are used in the
> bcm2835-audio consumer.

Okay, in this case please add this explanation to the commit message.

Best regards

>    Please let me know if you see a better way of
> doing this :)
>
> Thanks,
>
> Adrien
>
> [1] https://lore.kernel.org/all/20220502183045.206519-4-athierry@redhat.com/
>
